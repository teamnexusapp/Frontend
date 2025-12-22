import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'auth_exception.dart';
import 'api_service.dart';
// Feature flags not used here

abstract class AuthServiceInterface {
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? preferredLanguage,
  });

  Future<User?> signUpWithPhone({
    required String phoneNumber,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? password,
    String? preferredLanguage,
  });

  Future<bool> verifyEmailOTP({required String email, required String otp});

  Future<bool> verifyPhoneOTP({required String phoneNumber, required String otp});

  Future<bool> resendEmailOTP({required String email});

  Future<bool> resendPhoneOTP({required String phoneNumber});

  Future<User?> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImagePath,
    String? preferredLanguage,
  });

  Future<User?> signIn({required String email, required String password});

  Future<void> signOut();

  Future<User?> getCurrentUser();

  Stream<User?> authStateChanges();
}

class AuthService extends ChangeNotifier implements AuthServiceInterface {
  // Removed SharedPreferences; using in-memory storage for simplicity
  final Map<String, String> _inMemoryPrefs = {};
  User? _currentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();
  final ApiService _apiService = ApiService();

  User? get currentUser => _currentUser;

  AuthService() {
    // Minimal initialization; token will be managed by ApiService
    _initialize();
  }

  Future<void> _initialize() async {
    // Minimal initialization; token will be managed by ApiService
    try {
      await _apiService.getStoredToken();
    } catch (_) {}
  }

  // In-memory storage helpers
  Future<void> _setString(String key, String value) async {
    _inMemoryPrefs[key] = value;
  }

  Future<String?> _getString(String key) async {
    return _inMemoryPrefs[key];
  }

  Future<void> _removeString(String key) async {
    _inMemoryPrefs.remove(key);
  }

  Future<void> _saveUserToPrefs(User user) async {
    _currentUser = user;
    _authStateController.add(user);
    notifyListeners();
  }

  String _jsonEncode(Map<String, dynamic> data) {
    return jsonEncode(data);
  }

  Map<String, dynamic> _jsonDecode(String data) {
    final decoded = jsonDecode(data);
    return decoded is Map<String, dynamic>
        ? decoded
        : Map<String, dynamic>.from(decoded as Map);
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    String? username,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? preferredLanguage,
  }) async {
    try {
      // Validate email format
      if (!_isValidEmail(email)) {
        debugPrint('Invalid email format: $email');
        throw AuthException(AuthErrorCodes.invalidEmail);
      }

      // Validate password strength
      if (password.length < 8) {
        debugPrint('Password too short: ${password.length} characters');
        throw AuthException(AuthErrorCodes.passwordTooShort);
      }

      // Validate required fields for OTP
        if (username == null || username.isEmpty || 
          firstName == null || firstName.isEmpty || 
          lastName == null || lastName.isEmpty || 
          phoneNumber == null || phoneNumber.isEmpty) {
        debugPrint('Missing required fields - username: $username, firstName: $firstName, lastName: $lastName, phone: $phoneNumber');
        throw AuthException(AuthErrorCodes.serverError,
          details: 'All fields are required for registration');
      }

      debugPrint('Sending OTP for email: $email, username: $username, phone: $phoneNumber');
      
      // Send OTP via backend API
      Map<String, dynamic> otpResponse;
      try {
        otpResponse = await _apiService.sendOtp(
          email: email,
          username: username,
          firstName: firstName,
          lastName: lastName,
          password: password,
          phoneNumber: phoneNumber,
          languagePreference: preferredLanguage,
        );
        debugPrint('OTP sent successfully to email: $email');
        debugPrint('OTP Response: $otpResponse');
      } catch (e) {
        debugPrint('Failed to send OTP: $e');
        rethrow;
      }

      // Create temporary user object for local tracking
      final user = User(
        email: email,
        username: username,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        emailVerified: false,
        phoneVerified: false,  // We don't verify phone numbers
        preferredLanguage: preferredLanguage,
        createdAt: DateTime.now(),
      );

      // Store registration data for later verification (keyed by email)
      await _setString('registration_data_$email', _jsonEncode({
        'email': email,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'phoneNumber': phoneNumber,
        'preferredLanguage': preferredLanguage,
        'verification_id': otpResponse['verification_id'],
      }));

      debugPrint('OTP sent to email $email for user with phone $phoneNumber');

      return user;
    } on ApiException catch (e) {
      debugPrint('API sign up error: Status ${e.statusCode}, Message: ${e.message}');
      if (e.message.toLowerCase().contains('already')) {
        throw AuthException(AuthErrorCodes.emailAlreadyRegistered,
          details: 'This email is already registered');
      }
      if (e.statusCode == 422) {
        throw AuthException(AuthErrorCodes.serverError,
          details: 'Validation failed: ${e.message}');
      }
      if (e.statusCode >= 500) {
        throw AuthException(AuthErrorCodes.serverError,
          details: 'The backend server is temporarily unavailable. This may be because the server is starting up (this can take up to 30 seconds). Please wait a moment and try again.');
      }
      throw AuthException(AuthErrorCodes.serverError, 
        details: 'Server error (${e.statusCode}): ${e.message}');
    } on TimeoutException {
      throw AuthException(AuthErrorCodes.serverError,
        details: 'The server took too long to respond. It may be starting up. Please wait 30 seconds and try again.');
    } catch (e) {
      debugPrint('Sign up error: $e');
      rethrow;
    }
  }

  Future<User?> signUpWithPhone({
    required String phoneNumber,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? password,
    String? preferredLanguage,
  }) async {
    // Validate phone format
    if (!_isValidPhoneNumber(phoneNumber)) {
      throw AuthException(AuthErrorCodes.invalidPhone);
    }

    // Since we only verify email, delegate to signUpWithEmail if email is provided
    if (email != null && password != null) {
      return signUpWithEmail(
        email: email,
        password: password,
        username: username,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        preferredLanguage: preferredLanguage,
      );
    }
    
    throw AuthException(AuthErrorCodes.invalidEmail,
      details: 'Email is required for registration');
  }

  Future<bool> verifyEmailOTP({
    required String email,
    required String otp,
  }) async {
    try {
      // Verify OTP with backend (SendGrid sends 4-digit codes)
      if (otp.length != 4) {
        debugPrint('Invalid OTP length: ${otp.length}, expected 4');
        throw AuthException(AuthErrorCodes.invalidOtpFormat);
      }

      debugPrint('Verifying OTP: $otp for email: $email');

      // Get registration data
      final registrationDataJson = await _getString('registration_data_$email');
      if (registrationDataJson == null) {
        debugPrint('No registration data found for email: $email');
        debugPrint('Available keys: ${_inMemoryPrefs.keys.toList()}');
        throw AuthException(AuthErrorCodes.userNotFound,
          details: 'Registration data not found. Please register again.');
      }

      debugPrint('Found registration data for email: $email');
      final regData = _jsonDecode(registrationDataJson);
      final verificationId = regData['verification_id'];
      
      if (verificationId == null) {
        debugPrint('No verification_id found in registration data');
        throw AuthException(AuthErrorCodes.serverError,
          details: 'Verification ID not found. Please register again.');
      }
      
      // Verify OTP with backend API
      debugPrint('Calling backend API to verify OTP with verification_id: $verificationId');
      await _apiService.verifyOtp(
        email: email, 
        otp: otp,
        verificationId: verificationId,
      );
      debugPrint('Backend verification successful');

      // Update user with verified email
      final user = User(
        email: email,
        username: regData['username'],
        firstName: regData['firstName'],
        lastName: regData['lastName'],
        phoneNumber: regData['phoneNumber'],
        emailVerified: true,
        phoneVerified: false,  // We don't verify phone numbers
        preferredLanguage: regData['preferredLanguage'],
        createdAt: DateTime.now(),
      );

      // Save verified user
      await _saveUserToPrefs(user);
      await _removeString('registration_data_$email');

      return true;
    } on ApiException catch (e) {
      debugPrint('API OTP verification error: ${e.message} (Status: ${e.statusCode})');
      if (e.statusCode == 400 || e.message.toLowerCase().contains('invalid')) {
        throw AuthException(AuthErrorCodes.invalidOtpFormat,
          details: 'Invalid OTP code. Please check and try again.');
      } else if (e.statusCode == 404) {
        throw AuthException(AuthErrorCodes.userNotFound,
          details: 'User not found. Please register again.');
      } else {
        throw AuthException(AuthErrorCodes.serverError,
          details: 'Server error: ${e.message}');
      }
    } catch (e) {
      debugPrint('Unexpected OTP verification error: $e');
      rethrow;
    }
  }

  Future<bool> verifyPhoneOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    // Since we only verify email, find the email associated with this phone number
    // and call verifyEmailOTP instead
    try {
      String? foundEmail;
      
      final allKeys = _inMemoryPrefs.keys;
      for (final key in allKeys) {
        if (key.startsWith('registration_data_')) {
          final dataJson = _inMemoryPrefs[key];
          if (dataJson != null) {
            try {
              final data = _jsonDecode(dataJson);
              if (data['phoneNumber'] == phoneNumber) {
                foundEmail = data['email'];
                break;
              }
            } catch (e) {
              debugPrint('Error parsing registration data: $e');
            }
          }
        }
      }
      
      if (foundEmail == null) {
        debugPrint('No email found for phone: $phoneNumber');
        debugPrint('Available registration data: ${_inMemoryPrefs.keys.toList()}');
        throw AuthException(AuthErrorCodes.userNotFound,
          details: 'Registration data not found. Please start signup again.');
      }

      debugPrint('Found email $foundEmail for phone $phoneNumber, verifying...');
      // Verify using email
      return verifyEmailOTP(email: foundEmail, otp: otp);
    } on AuthException {
      rethrow;
    } catch (e) {
      debugPrint('Unexpected phone OTP verification error: $e');
      throw AuthException(AuthErrorCodes.serverError,
        details: 'Verification failed: ${e.toString()}');
    }
  }

  Future<bool> resendEmailOTP({required String email}) async {
    try {
      if (!_isValidEmail(email)) {
        throw AuthException(AuthErrorCodes.invalidEmail);
      }

      // Get registration data to resend OTP
      final registrationDataJson = await _getString('registration_data_$email');
      if (registrationDataJson != null) {
        final regData = _jsonDecode(registrationDataJson);
        
        // Resend OTP via backend API
        await _apiService.sendOtp(
          email: email,
          username: regData['username'],
          firstName: regData['firstName'],
          lastName: regData['lastName'],
          password: regData['password'],
          phoneNumber: regData['phoneNumber'],
          languagePreference: regData['preferredLanguage'],
        );
        
        debugPrint('OTP resent successfully to email: $email');
        return true;
      } else {
        throw AuthException(
          AuthErrorCodes.serverError,
          details: 'Registration data not found. Please start signup again.',
        );
      }
    } catch (e) {
      debugPrint('Resend OTP error: $e');
      rethrow;
    }
  }

  Future<bool> resendPhoneOTP({required String phoneNumber}) async {
    // Since we only verify email, find the email associated with this phone
    try {
      if (!_isValidPhoneNumber(phoneNumber)) {
        throw AuthException(AuthErrorCodes.invalidPhone);
      }

      // Find email from registration data
      String? foundEmail;
      final allKeys = _inMemoryPrefs.keys;
      for (final key in allKeys) {
        if (key.startsWith('registration_data_')) {
          final dataJson = _inMemoryPrefs[key];
          if (dataJson != null) {
            try {
              final data = _jsonDecode(dataJson);
              if (data['phoneNumber'] == phoneNumber) {
                foundEmail = data['email'];
                break;
              }
            } catch (e) {
              debugPrint('Error parsing registration data: $e');
            }
          }
        }
      }

      if (foundEmail != null) {
        return resendEmailOTP(email: foundEmail);
      } else {
        throw AuthException(
          AuthErrorCodes.serverError,
          details: 'Registration data not found. Please start signup again.',
        );
      }
    } catch (e) {
      debugPrint('Resend phone OTP error: $e');
      return false;
    }
  }

  Future<User?> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImagePath,
    String? preferredLanguage,
  }) async {
    try {
      if (_currentUser == null) {
        throw AuthException(AuthErrorCodes.noUserLoggedIn);
      }

      final updatedUser = _currentUser!.copyWith(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        profileImageUrl: profileImagePath,
        preferredLanguage: preferredLanguage,
        updatedAt: DateTime.now(),
      );

      await _saveUserToPrefs(updatedUser);

      return updatedUser;
    } catch (e) {
      debugPrint('Update profile error: $e');
      rethrow;
    }
  }

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Login via API (username can be email or actual username)
      final response = await _apiService.login(
        username: email,
        password: password,
      );

      debugPrint('User logged in: $email');

      // Fetch user profile after login
      final profileData = await _apiService.getProfile();
      final user = User.fromJson(profileData);

      // Store user locally
      await _saveUserToPrefs(user);

      return user;
    } on ApiException catch (e) {
      debugPrint('API login error: ${e.message}');
      if (e.statusCode == 401 || e.message.toLowerCase().contains('credentials')) {
        throw AuthException(AuthErrorCodes.invalidCredentials);
      } else if (e.message.toLowerCase().contains('not found')) {
        throw AuthException(AuthErrorCodes.userNotFound);
      } else if (e.statusCode >= 500) {
        throw AuthException(AuthErrorCodes.serverError,
          details: 'The backend server is temporarily unavailable. This may be because the server is starting up (this can take up to 30 seconds). Please wait a moment and try again.');
      }
      throw AuthException(AuthErrorCodes.serverError, details: e.message);
    } on TimeoutException {
      throw AuthException(AuthErrorCodes.serverError,
        details: 'The server took too long to respond. It may be starting up. Please wait 30 seconds and try again.');
    } catch (e) {
      debugPrint('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      // Logout from API
      await _apiService.logout();
      
      _currentUser = null;
      _inMemoryPrefs.remove('user');
      _authStateController.add(null);
      notifyListeners();
      
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Sign out error: $e');
      // Clear local data even if API call fails
      _currentUser = null;
      _inMemoryPrefs.remove('user');
      _authStateController.add(null);
      notifyListeners();
    }
  }

  Future<User?> getCurrentUser() async {
    // If we have a token, fetch fresh user data from API
    final token = await _apiService.getStoredToken();
    if (token != null) {
      try {
        final profileData = await _apiService.getProfile();
        final user = User.fromJson(profileData);
        await _saveUserToPrefs(user);
        return user;
      } catch (e) {
        debugPrint('Error fetching current user from API: $e');
        // Return cached user if API call fails
        return _currentUser;
      }
    }
    return _currentUser;
  }

  Stream<User?> authStateChanges() {
    return _authStateController.stream;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}

// Backwards compatibility: alias old class name to new implementation
typedef AuthServiceImpl = AuthService;
