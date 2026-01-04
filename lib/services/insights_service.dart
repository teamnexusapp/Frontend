import 'dart:convert';
import 'package:http/http.dart' as http;

class InsightsService {
  static const String baseUrl = 'https://fertipath-fastapi.onrender.com';

  Future<List<Map<String, dynamic>>> getInsights() async {
    final url = Uri.parse('$baseUrl/insights');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
      throw Exception('Unexpected insights response format');
    } else {
      throw Exception('Failed to fetch insights: ${response.statusCode}');
    }
  }
}
