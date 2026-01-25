import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

abstract class AuthServiceInterface {
  Future<User?> signIn(String email, String password);
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
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
  Future<void> forgotPassword({required String email, String? redirectUrl});
  Future<void> signOut();
  User? getCurrentUser();
  Stream<User?> authStateChanges();
  Future<void> resendEmailOTP(String email);
  Future<void> resendPhoneOTP(String phoneNumber);
  Future<User?> verifyEmailOTP(String email, String otp);
  Future<User?> verifyPhoneOTP(String phoneNumber, String otp);
  Future<void> updateUserProfile(Map<String, dynamic> updates);
}

class AuthService extends ChangeNotifier implements AuthServiceInterface {
  User? _currentUser;
  StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  
  final String _prefsKey = 'currentUser';
  
  AuthService() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_prefsKey);
      if (userJson != null && userJson.isNotEmpty) {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userMap);
        _authStateController.add(_currentUser);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user from prefs: $e');
      }
    }
  }

  Future<void> _saveUserToPrefs(User? user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (user != null) {
        await prefs.setString(_prefsKey, json.encode(user.toJson()));
      } else {
        await prefs.remove(_prefsKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user to prefs: $e');
      }
    }
  }

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      // Call the actual API login endpoint
      final apiService = ApiService();
      final loginResponse = await apiService.login(email: email, password: password);
      
      // Extract user data from response
      final userData = loginResponse['data'] ?? loginResponse;
      final user = User.fromJson(userData);
      
      // Save user to preferences
      await _saveUserToPrefs(user);
      
      _currentUser = user;
      _authStateController.add(_currentUser);
      notifyListeners();
      
      return _currentUser;
    } catch (e) {
      if (kDebugMode) {
        print('SignIn error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    _currentUser = User(
      id: '2',
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
    await _saveUserToPrefs(_currentUser);
    _authStateController.add(_currentUser);
    notifyListeners();
    return _currentUser;
  }

  @override
  Future<User?> signUpWithPhone({
    required String phoneNumber,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? password,
    String? preferredLanguage,
  }) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    _currentUser = User(
      id: '3',
      email: email ?? '$phoneNumber@example.com',
      firstName: firstName ?? 'Phone',
      lastName: lastName ?? 'User',
      phoneNumber: phoneNumber,
    );
    await _saveUserToPrefs(_currentUser);
    _authStateController.add(_currentUser);
    notifyListeners();
    return _currentUser;
  }

  @override
  Future<void> forgotPassword({required String email, String? redirectUrl}) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    print('Password reset email sent to $email');
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    await _saveUserToPrefs(null);
    _authStateController.add(null);
    notifyListeners();
  }

  @override
  User? getCurrentUser() {
    return _currentUser;
  }

  // Getter for convenience
  User? get currentUser => _currentUser;

  @override
  Stream<User?> authStateChanges() {
    return _authStateController.stream;
  }

  @override
  Future<void> resendEmailOTP(String email) async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> resendPhoneOTP(String phoneNumber) async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<User?> verifyEmailOTP(String email, String otp) async {
    await Future.delayed(Duration(seconds: 1));
    return _currentUser;
  }

  @override
  Future<User?> verifyPhoneOTP(String phoneNumber, String otp) async {
    await Future.delayed(Duration(seconds: 1));
    return _currentUser;
  }

  @override
  Future<void> updateUserProfile(Map<String, dynamic> updates) async {
    if (_currentUser != null) {
      // Update user properties
      if (updates.containsKey('firstName')) {
        // Note: User class is immutable, so we need to create a new instance
        // For simplicity, we'll just update the mock user
      }
      await _saveUserToPrefs(_currentUser);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}

