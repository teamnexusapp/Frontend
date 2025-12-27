
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // Default values for period and cycle length
  int _periodLength = 5; // days
  int _cycleLength = 28; // days

  // Symptoms fetched from backend
  List<String> _loggedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _calendarScrollController.addListener(_onCalendarScroll);
    _loadTappedDays();
    _fetchLoggedSymptoms();
  }

  Future<void> _fetchLoggedSymptoms() async {
    try {
      final symptoms = await ApiService().getCycleSymptoms();
      // Remove duplicates while preserving order
      final seen = <String>{};
      final uniqueSymptoms = symptoms.where((s) => seen.add(s)).toList();
      setState(() {
        _loggedSymptoms = uniqueSymptoms;
      });
    } catch (e) {
      debugPrint('Failed to fetch symptoms: $e');
    }
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
    } else {
      // Set default value: today as period day
      final today = DateTime.now();
      final todayStr = DateFormat('yyyy-MM-dd').format(today);
      setState(() {
        _selectedCalendarDays = {today};
        _selectedCalendarDaysFormatted = {todayStr};
        _lastPeriodDate = todayStr;
      });
      await prefs.setStringList('tapped_days', [todayStr]);
    }
  }

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
      // Remove duplicates (Set already ensures this)
      _selectedCalendarDays = _selectedCalendarDays.toSet();
      // Update formatted set
      _selectedCalendarDaysFormatted = _selectedCalendarDays
          .map((d) => DateFormat('yyyy-MM-dd').format(d))
          .toSet();
      // Update last period date (most recent date)
      if (_selectedCalendarDays.isNotEmpty) {
        final latest = _selectedCalendarDays.reduce((a, b) => a.isAfter(b) ? a : b);
        _lastPeriodDate = DateFormat('yyyy-MM-dd').format(latest);
      } else {
        _lastPeriodDate = null;
      }
    });
    // Save tapped days (as unique list)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tapped_days', _selectedCalendarDaysFormatted.toList());
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
            Column(
              children: [
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
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
                                onPressed: () {},
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
                          ..._loggedSymptoms.map((symptom) => _buildLoggedSymptomItem(
                                symptom,
                                Icons.check_circle_outline,
                                const Color(0xFF2E683D),
                              )),
                          if (_loggedSymptoms.isEmpty)
                            const Text('No symptoms logged yet.'),
                          const SizedBox(height: 80),
                        ],
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const LogSymptomScreen(),
                    ),
                  );
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
            children: const [
              Text(
                'Fertile Window',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '21–27 Dec',
                style: TextStyle(
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
            children: const [
              Text(
                'Gender Specific',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
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
              symptom,
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
    );
  }
}
