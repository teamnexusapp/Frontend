import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import 'home_screen.dart';

class GenderPredictionScreen extends StatefulWidget {
  const GenderPredictionScreen({Key? key}) : super(key: key);

  @override
  State<GenderPredictionScreen> createState() => _GenderPredictionScreenState();
}


class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  String? _selectedGender;
  DateTime? _ovulationDay;
  DateTime? _fertileStart;
  DateTime? _fertileEnd;
  bool _loading = true;

  final List<String> _genderOptions = ['Male', 'Female', 'No Preference'];

  @override
  void initState() {
    super.initState();
    _fetchOvulationDay();
  }

  Future<void> _fetchOvulationDay() async {
    setState(() => _loading = true);
    try {
      final api = ApiService();
      final headers = await api.getHeaders(includeAuth: true);
      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = response.body;
        final decoded = data.isNotEmpty
            ? (data.startsWith('[')
                ? List<Map<String, dynamic>>.from(jsonDecode(data).map((e) => Map<String, dynamic>.from(e)))
                : Map<String, dynamic>.from(jsonDecode(data)))
            : null;
        Map<String, dynamic>? latestCycle;
        if (decoded is List && decoded.isNotEmpty) {
          latestCycle = decoded.last;
        } else if (decoded is Map) {
          latestCycle = Map<String, dynamic>.from(decoded);
        }
        if (latestCycle != null) {
          if (latestCycle['ovulation_day'] != null) {
            _ovulationDay = DateTime.tryParse(latestCycle['ovulation_day']);
          }
          if (latestCycle['fertile_period_start'] != null && latestCycle['fertile_period_end'] != null) {
            _fertileStart = DateTime.tryParse(latestCycle['fertile_period_start']);
            _fertileEnd = DateTime.tryParse(latestCycle['fertile_period_end']);
          }
        }
      }
    } catch (e) {
      // Handle error
    }
    setState(() => _loading = false);
  }

  List<Map<String, String>> _getAdvice() {
    if (_ovulationDay == null || _selectedGender == null) return [];
    final List<Map<String, String>> advice = [];
    for (int i = -3; i <= 1; i++) {
      final day = _ovulationDay!.add(Duration(days: i));
      String tip;
      if (_selectedGender == 'Male') {
        tip = i == 0 ? 'Best chance for male conception.' : 'Lower chance for male.';
      } else if (_selectedGender == 'Female') {
        tip = i < 0 ? 'Best chance for female conception.' : 'Lower chance for female.';
      } else {
        tip = 'General advice for conception.';
      }
      advice.add({
        'date': DateFormat('d MMM').format(day),
        'tip': tip,
      });
    }
    return advice;
  }

  String? getFertileWindowText() {
    if (_fertileStart != null && _fertileEnd != null) {
      final formatter = DateFormat('d MMM');
      return '${formatter.format(_fertileStart!)}–${formatter.format(_fertileEnd!)}';
    }
    return null;
  }

  String? getOvulationDayText() {
    if (_ovulationDay != null) {
      return DateFormat('d MMM').format(_ovulationDay!);
    }
    return null;
  }

  // Update GenderPredictionScreen to look like a chat box
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed fixed header (AppBar with 'Gender Prediction')
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFFF5F5F0),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Disclaimer message before bubble section
                  Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5E5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFFD32F2F), width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info_outline, color: Color(0xFFD32F2F)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Disclaimer: This feature uses AI to provide gender prediction advice. These predictions may not be fully accurate and should not replace professional medical advice. Please consult a qualified doctor for health decisions.',
                            style: TextStyle(fontSize: 15, color: Color(0xFFD32F2F)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _chatBubble(
                    child: const Text('Select your gender expectation:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    isBot: true,
                  ),
                  const SizedBox(height: 12),
                  _chatBubble(
                    child: Wrap(
                      spacing: 12,
                      children: _genderOptions.map((option) {
                        final isSelected = _selectedGender == option;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedGender = option);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF2E683D) : const Color(0xFFA8D497),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    isBot: false,
                  ),
                  const SizedBox(height: 24),
                  if (_selectedGender != null && (_ovulationDay != null || (_fertileStart != null && _fertileEnd != null)))
                    _chatBubble(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (getFertileWindowText() != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Fertile Window: ${getFertileWindowText()!}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          if (getOvulationDayText() != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Ovulation Day: ${getOvulationDayText()!}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          Text('Advice for intercourse timing:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          ..._getAdvice().map((item) => Card(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  title: Text(item['date']!),
                                  subtitle: Text(item['tip']!),
                                ),
                              )),
                        ],
                      ),
                      isBot: true,
                    ),
                ],
              ),
            ),
    );
  }

  Widget _chatBubble({required Widget child, required bool isBot}) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isBot ? const Color(0xFFE6F4EA) : const Color(0xFF2E683D),
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      ),
    );
  }
}
