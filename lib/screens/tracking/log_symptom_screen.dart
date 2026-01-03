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
  List<String> get _selectedSymptoms {
    // Only add symptoms that have a selected option
    return _selectedOptions.entries
        .where((entry) => entry.value != null)
        .map((entry) => entry.value!)
        .toList();
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
                      // Get arguments from parent route
                      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
                      String? lastPeriodDate = args != null ? args['lastPeriodDate'] : null;
                      final cycleLength = args != null ? args['cycleLength'] : null;
                      final periodLength = args != null ? args['periodLength'] : null;
                      // If lastPeriodDate is null, set to current date
                      if (lastPeriodDate == null) {
                        lastPeriodDate = DateTime.now().toIso8601String().split('T')[0];
                      }
                      final payload = {
                        "last_period_date": lastPeriodDate,
                        "cycle_length": cycleLength,
                        "period_length": periodLength,
                        "symptoms": _selectedSymptoms,
                      };
                      try {
                        final api = ApiService();
                        final headers = await api.getHeaders(includeAuth: true);
                        final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
                        final response = await http.post(
                          url,
                          headers: headers,
                          body: jsonEncode(payload),
                        );
                        debugPrint('Save log response: ${response.statusCode}');
                        debugPrint('Save log body: ${response.body}');
                        if (response.statusCode == 200 || response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Log saved successfully!')),
                          );
                          Navigator.of(context).pop(true); // Indicate log was saved
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to save log: ${response.body}')),
                          );
                        }
                      } catch (e) {
                        debugPrint('Error saving log: ${e.toString()}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error saving log: ${e.toString()}')),
                        );
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
    final isExpanded = _expandedSymptom == symptomName;
    final options = _symptomOptions[symptomName] ?? [];

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
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
                    final isSelected = _selectedOptions[symptomName] == option;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOptions[symptomName] = option;
                          _expandedSymptom = null; // Collapse after selection
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
      ),
    );
  }
}
