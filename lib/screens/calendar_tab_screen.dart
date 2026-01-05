import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../widgets/swipeable_green_calendar.dart';
import 'tracking/log_symptom_screen.dart';
import '../services/api_service.dart';

class CalendarTabScreen extends StatefulWidget {
  const CalendarTabScreen({Key? key}) : super(key: key);

  @override
  State<CalendarTabScreen> createState() => _CalendarTabScreenState();
}

class _CalendarTabScreenState extends State<CalendarTabScreen> {
  final ScrollController _calendarScrollController = ScrollController();
  bool _isCalendarCollapsed = false;
  double _lastScrollOffset = 0;
  Set<DateTime> _selectedCalendarDays = {};
  // Store tapped days as yyyy-mm-dd strings
  Set<String> _selectedCalendarDaysFormatted = {};
  // Store last period date as yyyy-mm-dd string
  String? _lastPeriodDate;
  List<String> _loggedSymptoms = [];
  bool _isSymptomsLoading = false;
  String? _fertileStart;
  String? _fertileEnd;
  String? _ovulationDay;

  @override
  void initState() {
    super.initState();
    _calendarScrollController.addListener(_onCalendarScroll);
    _loadTappedDays();
    _fetchLoggedSymptoms();
    // No longer mark next period days after loading tapped days; will use API value.
  }

  Future<void> _loadTappedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDays = prefs.getStringList('tapped_days');
    if (savedDays != null && savedDays.isNotEmpty) {
      setState(() {
        _selectedCalendarDaysFormatted = savedDays.toSet();
        _selectedCalendarDays = savedDays
            .map((s) => DateTime.parse(s))
            .toSet();
        // Update last period date
        if (_selectedCalendarDays.isNotEmpty) {
          final latest = _selectedCalendarDays.reduce((a, b) => a.isAfter(b) ? a : b);
          _lastPeriodDate = DateFormat('yyyy-MM-dd').format(latest);
        } else {
          _lastPeriodDate = null;
        }
      });
    }
  }

  Future<void> _fetchLoggedSymptoms() async {
    setState(() {
      _isSymptomsLoading = true;
    });
    try {
      final api = ApiService();
      final headers = await api.getHeaders(includeAuth: true);
      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
      final response = await http.get(url, headers: headers);
      debugPrint('GET /insights/insights response: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          final latestCycle = data.last;
          debugPrint('Latest cycle: $latestCycle');
          if (latestCycle['fertile_period_start'] != null && latestCycle['fertile_period_end'] != null) {
            setState(() {
              _fertileStart = latestCycle['fertile_period_start'];
              _fertileEnd = latestCycle['fertile_period_end'];
            });
          }
          if (latestCycle['next_period'] != null && latestCycle['period_length'] != null) {
            // Use next_period and period_length from API to mark next period days
            final nextPeriodStart = DateTime.parse(latestCycle['next_period']);
            final periodLength = latestCycle['period_length'];
            final nextPeriodDays = List<DateTime>.generate(periodLength, (i) => nextPeriodStart.add(Duration(days: i)));
            setState(() {
              _selectedCalendarDays = {..._selectedCalendarDays, ...nextPeriodDays};
              _selectedCalendarDaysFormatted = _selectedCalendarDays
                .map((d) => DateFormat('yyyy-MM-dd').format(d))
                .toSet();
            });
            final prefs = await SharedPreferences.getInstance();
            await prefs.setStringList('tapped_days', _selectedCalendarDaysFormatted.toList());
          }
          if (latestCycle['symptoms'] != null) {
            debugPrint('Symptoms found: ${latestCycle['symptoms']}');
            setState(() {
              _loggedSymptoms = List<String>.from(latestCycle['symptoms']);
              _isSymptomsLoading = false;
            });
          } else {
            debugPrint('No symptoms found in latest cycle.');
          }
          if (latestCycle['ovulation_day'] != null) {
            setState(() {
              _ovulationDay = latestCycle['ovulation_day'];
            });
          }
        } else if (data is Map) {
          debugPrint('Data is a Map: $data');
          if (data['fertile_period_start'] != null && data['fertile_period_end'] != null) {
            setState(() {
              _fertileStart = data['fertile_period_start'];
              _fertileEnd = data['fertile_period_end'];
            });
          }
          if (data['next_period'] != null && data['period_length'] != null) {
            // Use next_period and period_length from API to mark next period days
            final nextPeriodStart = DateTime.parse(data['next_period']);
            final periodLength = data['period_length'];
            final nextPeriodDays = List<DateTime>.generate(periodLength, (i) => nextPeriodStart.add(Duration(days: i)));
            setState(() {
              _selectedCalendarDays = {..._selectedCalendarDays, ...nextPeriodDays};
              _selectedCalendarDaysFormatted = _selectedCalendarDays
                .map((d) => DateFormat('yyyy-MM-dd').format(d))
                .toSet();
            });
            final prefs = await SharedPreferences.getInstance();
            await prefs.setStringList('tapped_days', _selectedCalendarDaysFormatted.toList());
          }
          if (data['symptoms'] != null) {
            debugPrint('Symptoms found: ${data['symptoms']}');
            setState(() {
              _loggedSymptoms = List<String>.from(data['symptoms']);
              _isSymptomsLoading = false;
            });
          } else {
            debugPrint('No symptoms found in data map.');
          }
          if (data['ovulation_day'] != null) {
            setState(() {
              _ovulationDay = data['ovulation_day'];
            });
          }
        } else {
          debugPrint('Data is neither List nor Map: $data');
        }
      } else {
        debugPrint('Non-200 response, setting _loggedSymptoms to empty.');
        setState(() {
          _loggedSymptoms = [];
          _isSymptomsLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Exception in _fetchLoggedSymptoms: $e');
      setState(() {
        _loggedSymptoms = [];
        _isSymptomsLoading = false;
      });
    }
  }

  // Calculate period days from last period date and period length
  void _markPeriodDays({required String lastPeriodDate, required int periodLength}) {
    try {
      final startDate = DateTime.parse(lastPeriodDate);
      final periodDays = List<DateTime>.generate(
        periodLength,
        (i) => DateTime(startDate.year, startDate.month, startDate.day + i),
      );
      setState(() {
        _selectedCalendarDays = periodDays.toSet();
        _selectedCalendarDaysFormatted = periodDays
          .map((d) => DateFormat('yyyy-MM-dd').format(d))
          .toSet();
      });
    } catch (e) {
      // Handle parse error or invalid input
    }
  }

  // No longer needed: _markNextPeriodDays. Next period days will be set from API in _fetchLoggedSymptoms.

  @override
  void dispose() {
    _calendarScrollController.removeListener(_onCalendarScroll);
    _calendarScrollController.dispose();
    super.dispose();
  }

  void _onCalendarScroll() {
    final currentOffset = _calendarScrollController.offset;
    // Collapse when scrolling down, expand when scrolling up, with a threshold
    if (currentOffset > 60 && !_isCalendarCollapsed) {
      setState(() {
        _isCalendarCollapsed = true;
      });
    } else if (currentOffset < 20 && _isCalendarCollapsed) {
      setState(() {
        _isCalendarCollapsed = false;
      });
    }
    _lastScrollOffset = currentOffset;
  }

  void _toggleCalendarDate(DateTime date) async {
    final normalized = DateTime(date.year, date.month, date.day);
    setState(() {
      if (_selectedCalendarDays.any((d) => _isSameDay(d, normalized))) {
        _selectedCalendarDays =
            _selectedCalendarDays.where((d) => !_isSameDay(d, normalized)).toSet();
      } else {
        _selectedCalendarDays = {..._selectedCalendarDays, normalized};
      }
      // Update formatted set
      _selectedCalendarDaysFormatted = _selectedCalendarDays
          .map((d) => DateFormat('yyyy-MM-dd').format(d))
          .toSet();
      // The last period date is always the latest (maximum) tapped day,
      // regardless of order or grouping. This ensures that if the user taps
      // 2 Jan and 5 Jan, the last period date is 5 Jan.
      if (_selectedCalendarDays.isNotEmpty) {
        final latest = _selectedCalendarDays.reduce((a, b) => a.isAfter(b) ? a : b);
        _lastPeriodDate = DateFormat('yyyy-MM-dd').format(latest);
      } else {
        _lastPeriodDate = null;
      }
    });
    // Save tapped days
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tapped_days', _selectedCalendarDaysFormatted.toList());

    // Now perform the profile update (async, outside setState)
    if (_selectedCalendarDays.isNotEmpty) {
      try {
        final api = ApiService();
        final profileJson = await api.getProfile();
        final userData = profileJson['data'] ?? profileJson;
        // Retain all required fields, update only lastPeriodDate
        final int? cycleLength = userData['cycle_length'] ?? userData['cycleLength'];
        final int? periodLength = userData['period_length'] ?? userData['periodLength'];
        final int? age = userData['age'];
        final String? ttcHistory = userData['ttc_history'] ?? userData['ttcHistory'];
        final String? faithPreference = userData['faith_preference'] ?? userData['faithPreference'];
        final bool? audioPreference = userData['audio_preference'];
        await api.updateProfile(
          age: age,
          cycleLength: cycleLength,
          periodLength: periodLength,
          lastPeriodDate: _lastPeriodDate,
          ttcHistory: ttcHistory,
          faithPreference: faithPreference,
          audioPreference: audioPreference,
        );
      } catch (e) {
        debugPrint('Failed to sync last period date to profile: ${e.toString()}');
      }
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E683D),
      body: SafeArea(
        child: Stack(
          children: [
            // Back button
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                tooltip: 'Back to Home',
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 40),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isCalendarCollapsed ? 80 : null,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isCalendarCollapsed) ...[
                            const SizedBox(height: 10),
                            SwipeableGreenCalendar(
                              initialMonth: DateTime.now(),
                              selectedDates: _selectedCalendarDays,
                              onDateToggle: _toggleCalendarDate,
                            ),
                          ] else ...[
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isCalendarCollapsed = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('MMMM yyyy').format(DateTime.now()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.expand_more,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: RefreshIndicator(
                      onRefresh: _fetchLoggedSymptoms,
                      child: SingleChildScrollView(
                        controller: _calendarScrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cycle Summaries Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cycle Summaries',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFE5E5),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Disclaimer'),
                                        content: const Text(
                                          'This app uses AI to provide predictions and insights. These predictions may not be fully accurate and should not replace professional medical advice. Please verify all health data and predictions with a qualified doctor.',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFD32F2F), width: 1.5),
                                    ),
                                    child: const Icon(Icons.info_outline, color: Color(0xFFD32F2F), size: 14),
                                  ),
                                  label: const Text(
                                    'Disclaimer',
                                    style: TextStyle(
                                      color: Color(0xFFD32F2F),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildCycleSummary(),
                            const SizedBox(height: 32),
                            // Logged Symptoms Section
                            const Text(
                              'Logged Symptoms',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 18),
                            if (_isSymptomsLoading)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else ...[
                              if (_loggedSymptoms.isEmpty)
                                const Text('No symptoms logged yet.', style: TextStyle(color: Colors.grey)),
                              if (_loggedSymptoms.isNotEmpty)
                                ..._loggedSymptoms.map((symptom) => _buildLoggedSymptomItem(symptom, Icons.check_circle, const Color(0xFF2E683D))),
                            ],
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Floating Action Button
            Positioned(
              bottom: 32,
              right: 32,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF2E683D),
                elevation: 6,
                onPressed: () async {
                  final result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (context) => const LogSymptomScreen(),
                      settings: RouteSettings(
                        arguments: {
                          'lastPeriodDate': _lastPeriodDate,
                          'cycleLength': _selectedCalendarDays.length,
                          'periodLength': _selectedCalendarDays.length,
                        },
                      ),
                    ),
                  );
                  if (result == true) {
                    _fetchLoggedSymptoms();
                  }
                },
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCycleSummary() {
    // Format fertile window range
    String fertileWindowText = '';
    if (_fertileStart != null && _fertileEnd != null) {
      try {
        final start = DateTime.parse(_fertileStart!);
        final end = DateTime.parse(_fertileEnd!);
        final formatter = DateFormat('d MMM');
        fertileWindowText = '${formatter.format(start)}–${formatter.format(end)}';
      } catch (_) {
        fertileWindowText = '';
      }
    }
    // Format ovulation day
    String ovulationDayText = '';
    if (_ovulationDay != null) {
      try {
        final ovulationDate = DateTime.parse(_ovulationDay!);
        ovulationDayText = DateFormat('d MMM').format(ovulationDate);
      } catch (_) {
        ovulationDayText = '';
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Abnormalities',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'None',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7E9B7B),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Fertile Window',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                fertileWindowText.isNotEmpty ? fertileWindowText : '-',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ovulation Day',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                ovulationDayText.isNotEmpty ? ovulationDayText : '-',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 18),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE6F4EA),
                ),
                child: const Center(
                  child: Icon(
                    Icons.smart_toy,
                    size: 16,
                    color: Color(0xFF2E683D),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Normal',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(width: 14),
              Icon(
                Icons.lock,
                size: 16,
                color: Colors.grey,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Unlock Detailed Insights',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedSymptomItem(String symptom, IconData icon, Color iconColor) {
    // Always display as '<section> - <symptom>'
    String displaySymptom = symptom;
    String sendSymptom = symptom;
    if (symptom.contains(':')) {
      final parts = symptom.split(':');
      if (parts.length == 2) {
        displaySymptom = parts[0].trim() + ' - ' + parts[1].trim();
        sendSymptom = displaySymptom;
      }
    } else if (symptom.contains('-')) {
      final parts = symptom.split('-');
      if (parts.length == 2) {
        displaySymptom = parts[0].trim() + ' - ' + parts[1].trim();
        sendSymptom = displaySymptom;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          // Send the full displaySymptom string when tapped
          // TODO: Replace this with your actual send logic
          debugPrint('Symptom sent: ' + sendSymptom);
        },
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                displaySymptom,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
