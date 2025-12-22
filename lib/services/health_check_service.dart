import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class HealthCheckService {
  static const String baseUrl = 'https://fertility-fastapi.onrender.com';
  
  /// Check if the backend API is reachable and responding
  /// Returns true if healthy, false otherwise
  static Future<bool> checkBackendHealth() async {
    try {
      debugPrint('Checking backend health at: $baseUrl');
      
      // Try to reach the root endpoint or a health endpoint
      final response = await http.get(
        Uri.parse('$baseUrl/'),
      ).timeout(
        const Duration(seconds: 10),
      );
      
      debugPrint('Health check response: ${response.statusCode}');
      
      // Any response (even 404) means the server is up
      return response.statusCode < 500;
    } catch (e) {
      debugPrint('Backend health check failed: $e');
      return false;
    }
  }
  
  /// Ping the backend to wake it up (useful for Render free tier)
  /// Returns true when the backend responds
  static Future<bool> wakeUpBackend({int maxAttempts = 6}) async {
    debugPrint('Attempting to wake up backend...');
    
    for (int i = 0; i < maxAttempts; i++) {
      debugPrint('Wake-up attempt ${i + 1}/$maxAttempts');
      
      final isHealthy = await checkBackendHealth();
      if (isHealthy) {
        debugPrint('Backend is now responsive!');
        return true;
      }
      
      if (i < maxAttempts - 1) {
        // Wait 5 seconds before next attempt
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    
    debugPrint('Backend failed to wake up after $maxAttempts attempts');
    return false;
  }
}
