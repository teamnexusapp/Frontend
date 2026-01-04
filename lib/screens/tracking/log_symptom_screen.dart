import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';
import '../calendar_tab_screen.dart';

class LogSymptomScreen extends StatefulWidget {
  const LogSymptomScreen({super.key});

  @override
  State<LogSymptomScreen> createState() => _LogSymptomScreenState();
}

class _LogSymptomScreenState extends State<LogSymptomScreen> {
  String? _expandedSymptom;
  Map<String, String?> _selectedOptions = {};
  // Change Mood to allow multiple selections
  Map<String, List<String>> _multiSelectedOptions = {'Mood': []};

  List<String> get _selectedSymptoms {
    // For multi-select symptoms, add all selected values with container name
    List<String> symptoms = [];
    // Always add selected Mood values first
    for (var mood in _multiSelectedOptions['Mood'] ?? []) {
      symptoms.add('Mood -$mood');
    }
    // Add other selected symptoms
    _selectedOptions.forEach((key, value) {
      if (key != 'Mood' && value != null) {
        symptoms.add('$key -$value');
      }
    });
    return symptoms;
  }

  // Remove default values; will receive real data from parent

  final Map<String, List<String>> _symptomOptions = {
    'Mood': ['Fatigue', 'Anxiety', 'Mood swings', 'Sadness'],
    'Bleeding': ['Light', 'Medium', 'Heavy', 'Spotting'],
    'Cervical Mucus': ['Dry', 'Sticky', 'Creamy', 'Watery', 'Egg white'],
    'Sexual Activity': ['Protected', 'Unprotected', 'None'],
    'Pain': ['Mild', 'Moderate', 'Severe'],
    'Abdominal Cramps': ['Mild', 'Moderate', 'Severe'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Green appbar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF2E683D),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFFA8D497),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Log symptoms',
                  style: TextStyle(
                    color: Color(0xFFA8D497),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          // Symptom list
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  _buildSymptomContainer('Mood'),
                  const SizedBox(height: 16),
                  _buildSymptomContainer('Bleeding'),
                  const SizedBox(height: 16),
                  _buildSymptomContainer('Cervical Mucus'),
                  const SizedBox(height: 16),
                  _buildSymptomContainer('Sexual Activity'),
                  const SizedBox(height: 16),
                  _buildSymptomContainer('Pain'),
                  const SizedBox(height: 16),
                  _buildSymptomContainer('Abdominal Cramps'),
                ],
              ),
            ),
          ),
          // Bottom buttons
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF2E683D)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF2E683D),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Fetch user profile for cycleLength and periodLength
                      String? lastPeriodDate;
                      int? cycleLength;
                      int? periodLength;
                      final api = ApiService();
                      final profileJson = await api.getProfile();
                      // Defensive: handle both direct and nested user fields
                      final userData = profileJson['data'] ?? profileJson;
                      lastPeriodDate = userData['last_period_date'] ?? userData['lastPeriodDate'];
                      cycleLength = userData['cycle_length'] ?? userData['cycleLength'];
                      periodLength = userData['period_length'] ?? userData['periodLength'];
                      // Fallback: if lastPeriodDate is null, set to today
                      if (lastPeriodDate == null) {
                        lastPeriodDate = DateTime.now().toIso8601String().split('T')[0];
                      }
                      final payload = {
                        "last_period_date": lastPeriodDate,
                        "cycle_length": cycleLength,
                        "period_length": periodLength,
                        "symptoms": _selectedSymptoms,
                      };
                      final headers = await api.getHeaders(includeAuth: true);
                      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
                      final response = await http.post(
                        url,
                        headers: headers,
                        body: jsonEncode(payload),
                      );
                      if (response.statusCode == 200 || response.statusCode == 201) {
                        Navigator.of(context).pop('refresh');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF2E683D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save log',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomContainer(String symptomName) {
    final options = _symptomOptions[symptomName] ?? [];
    final isExpanded = _expandedSymptom == symptomName;
    return Container(
      // ...existing code...
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _expandedSymptom = isExpanded ? null : symptomName;
              });
            },
            child: Container(
              height: 83,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFA8D497),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.water_drop,
                        color: Color(0xFF2E683D),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    symptomName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  bool isSelected;
                  if (symptomName == 'Mood') {
                    isSelected = _multiSelectedOptions['Mood']?.contains(option) ?? false;
                  } else {
                    isSelected = _selectedOptions[symptomName] == option;
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (symptomName == 'Mood') {
                          if (isSelected) {
                            _multiSelectedOptions['Mood']?.remove(option);
                          } else {
                            _multiSelectedOptions['Mood']?.add(option);
                          }
                        } else {
                          _selectedOptions[symptomName] = option;
                          // Do NOT collapse after selection
                          // _expandedSymptom = null; // Remove this line
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E683D) : const Color(0xFFA8D497),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
