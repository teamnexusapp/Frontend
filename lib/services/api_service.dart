import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // User-related methods
  Future<Map<String, dynamic>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? preferredLanguage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'preferredLanguage': preferredLanguage,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> signUpWithPhone({
    required String phoneNumber,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? password,
    String? preferredLanguage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email ?? '',
      'phoneNumber': phoneNumber,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'preferredLanguage': preferredLanguage,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> verifyEmailOTP({
    required String email,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'emailVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> verifyPhoneOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'phoneNumber': phoneNumber,
      'phoneVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  Future<bool> resendEmailOTP({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> resendPhoneOTP({required String phoneNumber}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? profileImagePath,
    String? preferredLanguage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': userId,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'profileImageUrl': profileImagePath,
      'preferredLanguage': preferredLanguage,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'username': email.split('@')[0],
      'firstName': 'User',
      'lastName': 'Demo',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<String?> getStoredToken() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return null;
  }

  Future<Map<String, dynamic>> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'id': 'demo_user',
      'email': 'demo@example.com',
      'username': 'demo_user',
      'firstName': 'Demo',
      'lastName': 'User',
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  // Calendar/symptoms methods
  Future<List<Map<String, dynamic>>> getCycleSymptoms() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<Map<String, dynamic>> postCycleData(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'status': 'success', 'message': 'Data saved'};
  }

  // Verification methods
  Future<void> verifyOtp({
    required String email,
    required String otp,
    required String verificationId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> sendOtp({
    required String email,
    String? username,
    String? firstName,
    String? lastName,
    String? password,
    String? phoneNumber,
    String? languagePreference,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  // Get user profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/api/profile');
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Delete user account
  Future<void> deleteUser() async {
    try {
      await _dio.delete('/api/user');
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post('/api/auth/forgot-password', data: {'email': email});
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Reset password
  Future<void> resetPassword({required String token, required String newPassword}) async {
    try {
      await _dio.post('/api/auth/reset-password', data: {
        'token': token,
        'newPassword': newPassword,
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

}



