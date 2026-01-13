import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
>>>>>>> origin/main
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

  Future<User> signIn({required String email, required String password});

  Future<void> signOut();

  Future<User?> getCurrentUser();

  Stream<User?> authStateChanges();
}

<<<<<<< HEAD
class AuthService extends ChangeNotifier implements AuthServiceInterface {
  // Removed SharedPreferences; using in-memory storage for simplicity
  final Map<String, String> _inMemoryPrefs = {};
=======
class AuthServiceImpl extends ChangeNotifier implements AuthService {
  late SharedPreferences _prefs;
>>>>>>> origin/main
  User? _currentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();
  final ApiService _apiService = ApiService();

  User? get currentUser => _currentUser;

<<<<<<< HEAD
  AuthService() {
    // Minimal initialization; token will be managed by ApiService
=======
  AuthServiceImpl({String backendBaseUrl = ''}) : _backendBaseUrl = backendBaseUrl {
>>>>>>> origin/main
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

<<<<<<< HEAD
=======
  void _loadUserFromPrefs() {
    final userJson = _prefs.getString('user');
    if (userJson != null) {
      try {
        _currentUser = User.fromJson(Map<String, dynamic>.from(
          (userJson as dynamic) as Map,
        ));
      } catch (e) {
        debugPrint('Error loading user: $e');
      }
    }
  }

>>>>>>> origin/main
  Future<void> _saveUserToPrefs(User user) async {
    _currentUser = user;
    _authStateController.add(user);
    notifyListeners();
  }

  String _jsonEncode(Map<String, dynamic> data) {
    return jsonEncode(data);
  }

<<<<<<< HEAD
  Map<String, dynamic> _jsonDecode(String data) {
    final decoded = jsonDecode(data);
    return decoded is Map<String, dynamic>
        ? decoded
        : Map<String, dynamic>.from(decoded as Map);
=======
  String _backendEndpoint(String path) {
    final base = _backendBaseUrl.replaceAll(RegExp(r'/+$'), '');
    return '$base$path';
>>>>>>> origin/main
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
      if (!_isValidEmail(email)) {
        debugPrint('Invalid email format: $email');
        throw AuthException(AuthErrorCodes.invalidEmail);
      }
      if (_backendBaseUrl.isNotEmpty) {
        final uri = Uri.parse(_backendEndpoint('/api/register'));
        final res = await http.post(uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }));
        if (res.statusCode == 200 || res.statusCode == 201) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          final user = User.fromJson(data);
          await _saveUserToPrefs(user);
          return user;
        } else {
          throw AuthException(AuthErrorCodes.serverError,
              message: 'Register failed: ${res.body}');
        }
      }

      // Fallback/local behaviour
      if (password.length < 8) {
        debugPrint('Password too short: ${password.length} characters');
        throw AuthException(AuthErrorCodes.passwordTooShort);
      }

<<<<<<< HEAD
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
=======
      // Check if user already exists
      final existingUser = _prefs.getString('user_$email');
      if (existingUser != null) {
        throw AuthException(AuthErrorCodes.emailAlreadyRegistered);
      }

>>>>>>> origin/main
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

<<<<<<< HEAD
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

=======
      // Store temporary user for verification
      await _prefs.setString('temp_user_$email', _jsonEncode(user.toJson()));
      await _prefs.setString('user_password_$email', password);

      // In production, send OTP via email
      debugPrint('Sending OTP to $email');
>>>>>>> origin/main
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
<<<<<<< HEAD
    // Validate phone format
    if (!_isValidPhoneNumber(phoneNumber)) {
      throw AuthException(AuthErrorCodes.invalidPhone);
=======
    try {
      if (!_isValidPhoneNumber(phoneNumber)) {
        throw AuthException(AuthErrorCodes.invalidPhone);
      }

      // Check if phone already registered
      final existingUser = _prefs.getString('user_$phoneNumber');
      if (existingUser != null) {
        throw AuthException(AuthErrorCodes.phoneAlreadyRegistered);
      }

      final user = User(
        email: '',
        phoneNumber: phoneNumber,
        phoneVerified: false,
        createdAt: DateTime.now(),
      );

      // Store temporary user
      await _prefs.setString('temp_user_$phoneNumber', _jsonEncode(user.toJson()));

      // In production, send OTP via SMS
      debugPrint('Sending OTP to $phoneNumber');
      return user;
    } catch (e) {
      debugPrint('Sign up error: $e');
      rethrow;
>>>>>>> origin/main
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
      if (_backendBaseUrl.isNotEmpty) {
        final uri = Uri.parse(_backendEndpoint('/api/verify-phone'));
        final res = await http.post(uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'phone': phoneNumber, 'otp': otp}));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          final user = User.fromJson(data);
          await _saveUserToPrefs(user);
          return true;
        } else {
          throw AuthException(AuthErrorCodes.serverError,
              message: 'OTP verify failed: ${res.body}');
        }
      }

<<<<<<< HEAD
      debugPrint('Found email $foundEmail for phone $phoneNumber, verifying...');
      // Verify using email
      return verifyEmailOTP(email: foundEmail, otp: otp);
    } on AuthException {
=======
      debugPrint('Verifying OTP: $otp for phone: $phoneNumber');

      // Get temporary user
      final tempUserJson = _prefs.getString('temp_user_$phoneNumber');
      if (tempUserJson == null) {
        throw AuthException(AuthErrorCodes.userNotFound);
      }

      final user = User(
        email: '',
        phoneNumber: phoneNumber,
        phoneVerified: true,
        createdAt: DateTime.now(),
      );

      await _saveUserToPrefs(user);
      await _removeString('temp_user_$phoneNumber');

      return true;
    } catch (e) {
      debugPrint('OTP verification error: $e');
>>>>>>> origin/main
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
      if (_backendBaseUrl.isNotEmpty) {
        final uri = Uri.parse(_backendEndpoint('/api/users/$userId'));
        final res = await http.put(uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'firstName': firstName,
              'lastName': lastName,
              'dateOfBirth': dateOfBirth?.toIso8601String(),
              'gender': gender,
              'profileImageUrl': profileImagePath,
            }));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          final updated = User.fromJson(data);
          await _saveUserToPrefs(updated);
          return updated;
        } else {
          throw AuthException(AuthErrorCodes.serverError,
              message: 'Update failed: ${res.body}');
        }
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
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
<<<<<<< HEAD
      // Login with email address
      await _apiService.login(
        email: email,
        password: password,
      );
      debugPrint('User logged in with email: $email');

      // Fetch full user details after login (prefer /user/get_user for complete registration data)
      final userData = await _apiService.getUser();
      final user = User.fromJson(userData);

      // Store user locally
      await _saveUserToPrefs(user);

      return user; // Guaranteed non-null on success
    } on ApiException catch (e) {
      debugPrint('API login error: ${e.message}');
      if (e.statusCode == 401 || e.message.toLowerCase().contains('credentials')) {
        throw AuthException(AuthErrorCodes.invalidCredentials);
      } else if (e.message.toLowerCase().contains('not found')) {
=======
      // In production, call backend authentication
      final userJson = _prefs.getString('user_$email');
      if (userJson == null) {
>>>>>>> origin/main
        throw AuthException(AuthErrorCodes.userNotFound);
      } else if (e.statusCode >= 500) {
        throw AuthException(AuthErrorCodes.serverError,
          details: 'The backend server is temporarily unavailable. This may be because the server is starting up (this can take up to 30 seconds). Please wait a moment and try again.');
      }
<<<<<<< HEAD
      throw AuthException(AuthErrorCodes.serverError, details: e.message);
    } on TimeoutException {
      throw AuthException(AuthErrorCodes.serverError,
        details: 'The server took too long to respond. It may be starting up. Please wait 30 seconds and try again.');
=======

      // Load and return user
      _loadUserFromPrefs();
      return _currentUser;
>>>>>>> origin/main
    } catch (e) {
      debugPrint('Sign in error: $e');
      rethrow; // Propagate errors; never return null
    }
  }

  Future<void> signOut() async {
    try {
      // Logout from API (may fail if token was already cleared)
      await _apiService.logout();
    } catch (e) {
      debugPrint('Logout failed during sign out (continuing): $e');
    } finally {
      _currentUser = null;
      _inMemoryPrefs.remove('user');
      _authStateController.add(null);
      notifyListeners();
      debugPrint('User signed out successfully');
    }
  }

  Future<User?> getCurrentUser() async {
    // If we have a token, fetch fresh user data from API
    final token = await _apiService.getStoredToken();
    if (token != null) {
      try {
        // Prefer the endpoint that returns registration-derived credentials
        final userData = await _apiService.getUser();
        final user = User.fromJson(userData);
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
