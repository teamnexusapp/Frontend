import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      final response = await api.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List && data.isNotEmpty) {
          final latestCycle = data.last;
          if (latestCycle['ovulation_day'] != null) {
            setState(() {
              _ovulationDay = DateTime.parse(latestCycle['ovulation_day']);
            });
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

  // Update GenderPredictionScreen to look like a chat box
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D5A3A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        title: const Text('Gender Prediction', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFFF5F5F0),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
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
                  if (_selectedGender != null && _ovulationDay != null)
                    _chatBubble(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
