import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  StreamController<User?> _authStateController = StreamController<User?>.broadcast();
  ApiService _apiService = ApiService();

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

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? preferredLanguage,
  }) async {
    try {
      final user = await _apiService.signUpWithEmail(
        email: email, password: password, username: username,
        firstName: firstName, lastName: lastName,
        phoneNumber: phoneNumber, preferredLanguage: preferredLanguage,
      );
      _currentUser = User.fromJson(user);
      await _saveUserToPrefs(User.fromJson(user));
      _authStateController.add(_currentUser);
      notifyListeners();
      return User.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> verifyEmailOTP({required String email, required String otp}) async {
    try {
      final user = await _apiService.verifyEmailOTP(email: email, otp: otp);
      _currentUser = User.fromJson(user);
      await _saveUserToPrefs(User.fromJson(user));
      _authStateController.add(_currentUser);
      notifyListeners();
      return User.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> verifyPhoneOTP({required String phoneNumber, required String otp}) async {
    try {
      final user = await _apiService.verifyPhoneOTP(phoneNumber: phoneNumber, otp: otp);
      _currentUser = User.fromJson(user);
      await _saveUserToPrefs(User.fromJson(user));
      _authStateController.add(_currentUser);
      notifyListeners();
      return User.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendEmailOTP({required String email}) async {
    try {
      return await _apiService.resendEmailOTP(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendPhoneOTP({required String phoneNumber}) async {
    try {
      return await _apiService.resendPhoneOTP(phoneNumber: phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> updateUserProfile({
    String? firstName, String? lastName, String? dateOfBirth,
    String? gender, String? profileImagePath, String? preferredLanguage,
  }) async {
    try {
      if (_currentUser == null) throw Exception('No user logged in');
      
      final updatedUser = await _apiService.updateUserProfile(
        userId: _currentUser!.id,
        firstName: firstName, lastName: lastName,
        dateOfBirth: dateOfBirth, gender: gender,
        profileImagePath: profileImagePath,
        preferredLanguage: preferredLanguage,
      );
      
      _currentUser = User.fromJson(updatedUser);
      await _saveUserToPrefs(User.fromJson(updatedUser));
      _authStateController.add(_currentUser);
      notifyListeners();
      return User.fromJson(updatedUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signIn({required String email, required String password}) async {
    try {
      final user = await _apiService.signIn(email: email, password: password);
      _currentUser = User.fromJson(user);
      await _saveUserToPrefs(User.fromJson(user));
      _authStateController.add(_currentUser);
      notifyListeners();
      return User.fromJson(user);
    } catch (e) {
      rethrow;
    }
  }

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
  // Sign up with phone number
  Future<User?> signUpWithPhone(String phoneNumber, String password) async {
    try {
      final response = await _dio.post('/api/auth/phone-signup', data: {
        'phoneNumber': phoneNumber,
        'password': password,
      });
      
      final user = response.data['user'];
      _currentUser = User.fromJson(user);
      await _saveUserToPrefs(_currentUser!);
      return _currentUser;
    } catch (e) {
      throw _handleError(e);
    }
  }

}
