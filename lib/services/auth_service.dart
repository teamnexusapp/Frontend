import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  final ApiService _apiService = ApiService();
  
  // Store OTP verification IDs temporarily
  String? _lastVerificationId;

  AuthService() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userMap);
        _authStateController.add(_currentUser);
      } catch (e) {
        if (kDebugMode) print('Error loading user: $e');
      }
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
  }

  Future<void> _removeUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }

  // Sign up with email - sends OTP
  Future<Map<String, dynamic>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? preferredLanguage,
  }) async {
    try {
      final response = await _apiService.sendOtp(
        email: email,
        password: password,
        username: username,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber ?? '',
        languagePreference: preferredLanguage,
      );
      
      // Store verification ID for later use
      if (response.containsKey('verification_id')) {
        _lastVerificationId = response['verification_id'];
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign up with phone - sends OTP
  Future<Map<String, dynamic>> signUpWithPhone({
    required String phoneNumber,
    required String password,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? preferredLanguage,
  }) async {
    try {
      final response = await _apiService.sendOtp(
        email: email ?? '',
        password: password,
        username: username ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        phoneNumber: phoneNumber,
        languagePreference: preferredLanguage,
      );
      
      // Store verification ID for later use
      if (response.containsKey('verification_id')) {
        _lastVerificationId = response['verification_id'];
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Verify OTP for email or phone
  Future<User> verifyEmailOTP({
    required String email,
    required String otp,
    String? verificationId,
  }) async {
    try {
      final response = await _apiService.verifyOtp(
        email: email,
        otp: otp,
        verificationId: verificationId ?? _lastVerificationId ?? '',
      );
      
      // Save token if provided
      if (response.containsKey('access_token')) {
        await _apiService.saveToken(response['access_token']);
      }
      
      // Extract user data
      final userData = response['user'] ?? response;
      _currentUser = User.fromJson(userData);
      await _saveUserToPrefs(_currentUser!);
      _authStateController.add(_currentUser);
      notifyListeners();
      
      return _currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> verifyPhoneOTP({
    required String phoneNumber,
    required String otp,
    String? verificationId,
  }) async {
    try {
      final response = await _apiService.verifyOtp(
        email: phoneNumber,
        otp: otp,
        verificationId: verificationId ?? _lastVerificationId ?? '',
      );
      
      // Save token if provided
      if (response.containsKey('access_token')) {
        await _apiService.saveToken(response['access_token']);
      }
      
      // Extract user data
      final userData = response['user'] ?? response;
      _currentUser = User.fromJson(userData);
      await _saveUserToPrefs(_currentUser!);
      _authStateController.add(_currentUser);
      notifyListeners();
      
      return _currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  // Resend OTP - reuse sendOtp method
  Future<bool> resendEmailOTP({required String email}) async {
    try {
      // This would need to be implemented in ApiService
      // For now, return true as a placeholder
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendPhoneOTP({required String phoneNumber}) async {
    try {
      // This would need to be implemented in ApiService
      // For now, return true as a placeholder
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Update user profile
  Future<User?> updateUserProfile({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? profileImagePath,
    String? preferredLanguage,
  }) async {
    try {
      if (_currentUser == null) throw Exception('No user logged in');
      
      final response = await _apiService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        profileImageUrl: profileImagePath,
        languagePreference: preferredLanguage,
      );
      
      _currentUser = User.fromJson(response);
      await _saveUserToPrefs(_currentUser!);
      _authStateController.add(_currentUser);
      notifyListeners();
      
      return _currentUser;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _apiService.login(email: email, password: password);
      
      // Save token if provided
      if (response.containsKey('access_token')) {
        await _apiService.saveToken(response['access_token']);
      }
      
      // Extract user data
      final userData = response['user'] ?? response;
      _currentUser = User.fromJson(userData);
      await _saveUserToPrefs(_currentUser!);
      _authStateController.add(_currentUser);
      notifyListeners();
      
      return _currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _apiService.logout();
    } catch (e) {
      if (kDebugMode) print('Logout failed: $e');
    }
    _currentUser = null;
    await _removeUserFromPrefs();
    _authStateController.add(null);
    notifyListeners();
  }

  User? getCurrentUser() => _currentUser;

  User? get currentUser => _currentUser;
  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}
