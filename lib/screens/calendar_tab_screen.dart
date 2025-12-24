import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/swipeable_green_calendar.dart';

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

  @override
  void initState() {
    super.initState();
    _calendarScrollController.addListener(_onCalendarScroll);
  }

  @override
  void dispose() {
    _calendarScrollController.removeListener(_onCalendarScroll);
    _calendarScrollController.dispose();
    super.dispose();
  }

  void _onCalendarScroll() {
    final currentOffset = _calendarScrollController.offset;
    if ((currentOffset - _lastScrollOffset).abs() > 10) {
      if (currentOffset > _lastScrollOffset && currentOffset > 50) {
        if (!_isCalendarCollapsed) {
          setState(() {
            _isCalendarCollapsed = true;
          });
        }
      } else if (currentOffset < _lastScrollOffset) {
        if (_isCalendarCollapsed) {
          setState(() {
            _isCalendarCollapsed = false;
          });
        }
      }
      _lastScrollOffset = currentOffset;
    }
  }

  void _toggleCalendarDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    setState(() {
      if (_selectedCalendarDays.any((d) => _isSameDay(d, normalized))) {
        _selectedCalendarDays =
            _selectedCalendarDays.where((d) => !_isSameDay(d, normalized)).toSet();
      } else {
        _selectedCalendarDays = {..._selectedCalendarDays, normalized};
      }
    });
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E683D),
      body: SafeArea(
        child: Column(
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _calendarScrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Cycle summaries',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCycleSummary(),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Logged Symptoms',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLoggedSymptomItem('Bleeding', 7),
                      _buildLoggedSymptomItem('Mood', 14),
                      _buildLoggedSymptomItem('Cervical Mucus', 21),
                      _buildLoggedSymptomItem('Pain', 28),
                      _buildLoggedSymptomItem('Notes', 30),
                    ],
                  ),
                ),
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
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Abnormalities',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'None',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Fertile window',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '21st - 27 Dec',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Fertile Window (Gender specific)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '4',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1, height: 14),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA8D497),
                ),
                child: const Center(
                  child: Icon(
                    Icons.smart_toy,
                    size: 14,
                    color: Color(0xFF2E683D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Normal',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2E683D),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.lock,
                size: 16,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Unlock detailed insights and chat with verified doctors',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedSymptomItem(String symptom, int day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.grey.shade400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              symptom,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Text(
            '$day',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
