
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiService {
  static const String baseUrl = 'https://fertility-fastapi.onrender.com';
  
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _accessToken;

  // Set access token after login
  void setAccessToken(String token) {
    _accessToken = token;
  }

  // Get stored token
  Future<String?> getStoredToken() async {
    if (_accessToken != null) return _accessToken;
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString('access_token');
      return _accessToken;
    } catch (e) {
      debugPrint('Error getting stored token: $e');
      return null;
    }
  }

  // Save token to storage
  Future<void> saveToken(String token) async {
    _accessToken = token;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
    } catch (e) {
      debugPrint('Error saving token: $e');
    }
  }

  // Clear token
  Future<void> clearToken() async {
    _accessToken = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
    } catch (e) {
      debugPrint('Error clearing token: $e');
    }
  }

  // Get headers - automatically loads token if needed
  Future<Map<String, String>> _getHeaders({bool includeAuth = false}) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    
    if (includeAuth) {
      final token = await getStoredToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        debugPrint('Using auth token: ${token.substring(0, 20)}...');
      } else {
        debugPrint('Warning: No auth token available for authenticated request');
      }
    }
    
    return headers;
  }

  // Send OTP and Registration (with retry logic for server wake-up)
  Future<Map<String, dynamic>> sendOtp({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
    required String phoneNumber,
    String? languagePreference,
    String? role,
    int retryCount = 0,
  }) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/auth/send-otp');
      
        final requestBody = {
          'email': email,
          'username': username,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'phone_number': phoneNumber,
          'language_preference': (languagePreference ?? 'en').toLowerCase(),
          'role': 'user',
        };
      
      debugPrint('Sending OTP request to: $url (attempt ${retryCount + 1})');
        debugPrint('Request body: ${jsonEncode(requestBody)}');
      
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException('OTP request timed out after 60 seconds');
        },
      );

      debugPrint('Send OTP Response: ${response.statusCode}');
      debugPrint('Send OTP Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode >= 500 && retryCount < 2) {
        // Backend might be waking up (Render free tier), retry after delay
        debugPrint('Server error, retrying in 5 seconds...');
        await Future.delayed(const Duration(seconds: 5));
        return sendOtp(
          email: email,
          username: username,
          firstName: firstName,
          lastName: lastName,
          password: password,
          phoneNumber: phoneNumber,
          languagePreference: languagePreference,
          role: role,
          retryCount: retryCount + 1,
        );
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } on TimeoutException catch (e) {
      if (retryCount < 2) {
        debugPrint('Timeout, retrying in 5 seconds...');
        await Future.delayed(const Duration(seconds: 5));
        return sendOtp(
          email: email,
          username: username,
          firstName: firstName,
          lastName: lastName,
          password: password,
          phoneNumber: phoneNumber,
          languagePreference: languagePreference,
          role: role,
          retryCount: retryCount + 1,
        );
      }
      debugPrint('Send OTP timeout error: $e');
      rethrow;
    } catch (e) {
      debugPrint('Send OTP error: $e');
      rethrow;
    }
  }

  // Verify OTP and Complete Registration
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
    required String verificationId,
  }) async {
    try {
      final headers = await _getHeaders();
      final url = Uri.parse('$baseUrl/auth/verify-otp');
      debugPrint('Verifying OTP request to: $url');
      
      final requestBody = {
        'verification_id': verificationId,
        'otp_code': otp,
      };
      
      debugPrint('Verify OTP request body: ${jsonEncode(requestBody)}');
      
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      ).timeout(
        const Duration(seconds: 45),
        onTimeout: () {
          throw TimeoutException('OTP verification request timed out after 45 seconds');
        },
      );

      debugPrint('Verify OTP Response: ${response.statusCode}');
      debugPrint('Verify OTP Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } on TimeoutException catch (e) {
      debugPrint('Verify OTP timeout error: $e');
      rethrow;
    } catch (e) {
      debugPrint('Verify OTP error: $e');
      rethrow;
    }
  }

  // Login (with retry logic for server wake-up)
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    int retryCount = 0,
  }) async {
    try {
      debugPrint('Login attempt ${retryCount + 1} for user: $email');
      
      final headers = await _getHeaders();
      final body = {
        'email': email,
        'password': password,
      };
      
      debugPrint('Login headers: $headers');
      debugPrint('Login request body: ${jsonEncode(body)}');
      
      // First try the token endpoint with JSON (if backend supports JSON)
      final primaryUrl = Uri.parse('$baseUrl/auth/token');
      debugPrint('Login primary URL: $primaryUrl');
      var response = await http.post(
        primaryUrl,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 45),
      );

      debugPrint('Login Response: ${response.statusCode}');
      debugPrint('Login Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['access_token'] != null) {
          await saveToken(data['access_token']);
        }
        return data;
      } else if (retryCount == 0) {
        // Many FastAPI OAuth2 setups expect x-www-form-urlencoded with 'username' and 'password'
        final formHeaders = {
          ...headers,
          'Content-Type': 'application/x-www-form-urlencoded',
        };
        final formBody = 'username=' + Uri.encodeQueryComponent(email) +
            '&password=' + Uri.encodeQueryComponent(password);
        debugPrint('Primary login failed (${response.statusCode}). Trying form-encoded to /auth/token');
        response = await http.post(
          primaryUrl,
          headers: formHeaders,
          body: formBody,
        ).timeout(const Duration(seconds: 45));

        debugPrint('Form Login Response: ${response.statusCode}');
        debugPrint('Form Login Body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['access_token'] != null) {
            await saveToken(data['access_token']);
          }
          return data;
        }

        // Some backends expose a JSON login at /auth/login instead of /auth/token
        final altUrl = Uri.parse('$baseUrl/auth/login');
        debugPrint('Form login failed (${response.statusCode}). Trying alternate URL: $altUrl');
        response = await http.post(
          altUrl,
          headers: headers,
          body: jsonEncode(body),
        ).timeout(
          const Duration(seconds: 45),
        );

        debugPrint('Alt Login Response: ${response.statusCode}');
        debugPrint('Alt Login Body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['access_token'] != null) {
            await saveToken(data['access_token']);
          }
          return data;
        } else {
          throw ApiException(
            statusCode: response.statusCode,
            message: _extractErrorMessage(response),
          );
        }
      } else if (response.statusCode >= 500 && retryCount < 2) {
        // Backend might be waking up (Render free tier), retry after delay
        debugPrint('Server error during login, retrying in 5 seconds...');
        await Future.delayed(const Duration(seconds: 5));
        return login(
          email: email,
          password: password,
          retryCount: retryCount + 1,
        );
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } on TimeoutException {
      if (retryCount < 2) {
        debugPrint('Login timeout, retrying in 5 seconds...');
        await Future.delayed(const Duration(seconds: 5));
        return login(
          email: email,
          password: password,
          retryCount: retryCount + 1,
        );
      }
      rethrow;
    } catch (e) {
      debugPrint('Login error: $e');
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final headers = await _getHeaders(includeAuth: true);
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: headers,
      );

      debugPrint('Logout Response: ${response.statusCode}');

      await clearToken();

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
      await clearToken();
      rethrow;
    }
  }

  // Forgot Password
  Future<void> forgotPassword({
    required String email,
    String? redirectUrl,
  }) async {
    try {
      final headers = await _getHeaders();
      final body = {'email': email};
      if (redirectUrl != null && redirectUrl.isNotEmpty) {
        body['redirect_url'] = redirectUrl;
      }
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgot_password'),
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Forgot Password Response: ${response.statusCode}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Forgot Password error: $e');
      rethrow;
    }
  }

  // Reset Password
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    if (newPassword.length < 8) {
      throw ApiException(statusCode: 400, message: 'Password must be at least 8 characters long');
    }

    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset_password'),
        headers: headers,
        body: jsonEncode({'token': token, 'new_password': newPassword}),
      );

      debugPrint('Reset Password Response: ${response.statusCode}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Reset Password error: $e');
      rethrow;
    }
  }

  // Get User
  Future<Map<String, dynamic>> getUser() async {
    try {
      final headers = await _getHeaders(includeAuth: true);
      
      final response = await http.get(
        Uri.parse('$baseUrl/user/get_user'),
        headers: headers,
      );

      debugPrint('Get User Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Get User error: $e');
      rethrow;
    }
  }

  // Get Profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final headers = await _getHeaders(includeAuth: true);
      
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
      );

      debugPrint('Get Profile Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // If email is missing or empty, fall back to the more complete get_user endpoint
        try {
          final map = (data is Map<String, dynamic>)
              ? data
              : (data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{});
          var candidate = map;
          if (candidate['data'] is Map<String, dynamic>) {
            candidate = Map<String, dynamic>.from(candidate['data']);
          }
          if (candidate['user'] is Map<String, dynamic>) {
            candidate = {...candidate, ...Map<String, dynamic>.from(candidate['user'])};
          }
          final email = candidate['email'] ?? candidate['email_address'];
          if (email is! String || email.trim().isEmpty) {
            debugPrint('Profile missing email; fetching from /user/get_user');
            final fullUser = await getUser();
            return fullUser;
          }
        } catch (e) {
          debugPrint('Profile parsing error, attempting fallback get_user: $e');
          try {
            final fullUser = await getUser();
            return fullUser;
          } catch (_) {}
        }
        return data;
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Get Profile error: $e');
      rethrow;
    }
  }

  // Update Profile
  Future<Map<String, dynamic>> updateProfile({
    int? age,
    int? cycleLength,
    String? lastPeriodDate,
    String? ttcHistory,
    String? faithPreference,
    bool? audioPreference,
  }) async {
    try {
      final headers = await _getHeaders(includeAuth: true);
      final body = <String, dynamic>{};
      if (age != null) body['age'] = age;
      if (cycleLength != null) body['cycle_length'] = cycleLength;
      if (lastPeriodDate != null) body['last_period_date'] = lastPeriodDate;
      if (ttcHistory != null) body['ttc_history'] = ttcHistory;
      if (faithPreference != null) body['faith_preference'] = faithPreference;
      if (audioPreference != null) body['audio_preference'] = audioPreference;

      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
        body: jsonEncode(body),
      );

      debugPrint('Update Profile Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }
    } catch (e) {
      debugPrint('Update Profile error: $e');
      rethrow;
    }
  }

  // Delete User
  Future<void> deleteUser() async {
    try {
      final headers = await _getHeaders(includeAuth: true);
      
      final response = await http.delete(
        Uri.parse('$baseUrl/user/delete_user'),
        headers: headers,
      );

      debugPrint('Delete User Response: ${response.statusCode}');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(response),
        );
      }

      await clearToken();
    } catch (e) {
      debugPrint('Delete User error: $e');
      rethrow;
    }
  }

  // Extract error message from response
  String _extractErrorMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      if (data is Map && data['detail'] != null) {
        return data['detail'].toString();
      }
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return 'Request failed with status ${response.statusCode}';
    } catch (e) {
      return 'Request failed with status ${response.statusCode}';
    }
  }
}

// Custom API Exception
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
