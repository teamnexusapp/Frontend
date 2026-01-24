import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../widgets/reminder_panel.dart';
import 'tracking/log_symptom_screen.dart';
import '../services/api_service.dart';
import '../services/notification_reminder_service.dart';

class CalendarTabScreen extends StatefulWidget {
  final ValueNotifier<bool>? refreshNotifier;
  const CalendarTabScreen({Key? key, this.refreshNotifier}) : super(key: key);

  @override
  State<CalendarTabScreen> createState() => _CalendarTabScreenState();
}

class _CalendarTabScreenState extends State<CalendarTabScreen> {
  // Calendar view mode
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // Scroll controller for collapse behavior
  final ScrollController _scrollController = ScrollController();
  bool _isCalendarCollapsed = false;
  
  // Period tracking
  Set<DateTime> _periodDays = {};
  Set<DateTime> _nextPeriodDays = {};
  DateTime? _ovulationDay;
  DateTime? _fertileStart;
  DateTime? _fertileEnd;
  
  // Symptoms and API data
  List<String> _loggedSymptoms = [];
  bool _isLoading = false;
  
  // Reminders
  late NotificationReminderService _reminderService;
  bool _remindersInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPersistedData();
    _fetchInsights();
    _initializeReminders();
    widget.refreshNotifier?.addListener(_handleRefresh);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    widget.refreshNotifier?.removeListener(_handleRefresh);
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 80 && !_isCalendarCollapsed) {
      setState(() => _isCalendarCollapsed = true);
    } else if (_scrollController.offset < 40 && _isCalendarCollapsed) {
      setState(() => _isCalendarCollapsed = false);
    }
  }

  void _handleRefresh() {
    if (widget.refreshNotifier?.value == true) {
      _fetchInsights();
      widget.refreshNotifier?.value = false;
    }
  }

  Future<void> _initializeReminders() async {
    _reminderService = NotificationReminderService();
    await _reminderService.initialize();
    setState(() => _remindersInitialized = true);
  }

  Future<void> _loadPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDays = prefs.getStringList('period_days');
    if (savedDays != null) {
      setState(() {
        _periodDays = savedDays.map((s) => DateTime.parse(s)).toSet();
      });
    }
  }

  Future<void> _fetchInsights() async {
    setState(() => _isLoading = true);
    try {
      final api = ApiService();
      final headers = await api.getHeaders(includeAuth: true);
      final url = Uri.parse('${ApiService.baseUrl}/insights/insights');
      final response = await http.get(url, headers: headers);
      
      debugPrint('Insights response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final latestCycle = data is List && data.isNotEmpty ? data.last : data;
        
        if (latestCycle is Map) {
          // Parse fertile period
          if (latestCycle['fertile_period_start'] != null && latestCycle['fertile_period_end'] != null) {
            _fertileStart = DateTime.tryParse(latestCycle['fertile_period_start']);
            _fertileEnd = DateTime.tryParse(latestCycle['fertile_period_end']);
          }
          
          // Parse ovulation day
          if (latestCycle['ovulation_day'] != null) {
            _ovulationDay = DateTime.tryParse(latestCycle['ovulation_day']);
          }
          
          // Parse next period
          if (latestCycle['next_period'] != null && latestCycle['period_length'] != null) {
            final nextPeriodStart = DateTime.parse(latestCycle['next_period']);
            final periodLength = latestCycle['period_length'] as int;
            _nextPeriodDays = List<DateTime>.generate(
              periodLength,
              (i) => DateTime(nextPeriodStart.year, nextPeriodStart.month, nextPeriodStart.day + i),
            ).toSet();
          }
          
          // Parse symptoms
          if (latestCycle['symptoms'] != null) {
            _loggedSymptoms = List<String>.from(latestCycle['symptoms']);
          }
          
          setState(() {});
        }
      }
    } catch (e) {
      debugPrint('Error fetching insights: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _togglePeriodDay(DateTime day) async {
    final normalized = DateTime(day.year, day.month, day.day);
    
    setState(() {
      if (_periodDays.any((d) => isSameDay(d, normalized))) {
        _periodDays.removeWhere((d) => isSameDay(d, normalized));
      } else {
        _periodDays.add(normalized);
      }
    });
    
    // Persist to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'period_days',
      _periodDays.map((d) => DateFormat('yyyy-MM-dd').format(d)).toList(),
    );
    
    // Update profile with last period date
    if (_periodDays.isNotEmpty) {
      try {
        final lastPeriodDate = _periodDays.reduce((a, b) => a.isAfter(b) ? a : b);
        final api = ApiService();
        
        // Get current profile to preserve other fields
        final profile = await api.getProfile();
        final userData = profile['data'] ?? profile;
        
        await api.updateProfile(
          age: userData['age'],
          cycleLength: userData['cycle_length'] ?? userData['cycleLength'],
          periodLength: userData['period_length'] ?? userData['periodLength'],
          lastPeriodDate: DateFormat('yyyy-MM-dd').format(lastPeriodDate),
          ttcHistory: userData['ttc_history'] ?? userData['ttcHistory'],
          faithPreference: userData['faith_preference'] ?? userData['faithPreference'],
          audioPreference: userData['audio_preference'],
        );
        
        // Refresh insights to get updated predictions
        _fetchInsights();
      } catch (e) {
        debugPrint('Error updating profile: $e');
      }
    }
  }

  Color _getDayColor(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    
    // Ovulation day - green
    if (_ovulationDay != null && isSameDay(normalized, _ovulationDay!)) {
      return const Color(0xFF4CAF50);
    }
    
    // Fertile window - light teal/green
    if (_fertileStart != null && _fertileEnd != null) {
      if ((normalized.isAfter(_fertileStart!) || isSameDay(normalized, _fertileStart!)) &&
          (normalized.isBefore(_fertileEnd!) || isSameDay(normalized, _fertileEnd!))) {
        return const Color(0xFF80CBC4);
      }
    }
    
    // Period days (logged) - light pink
    if (_periodDays.any((d) => isSameDay(d, normalized))) {
      return const Color(0xFFFFCDD2);
    }
    
    return Colors.transparent;
  }

  BoxDecoration _getDayDecoration(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    
    // Next period days - red border
    if (_nextPeriodDays.any((d) => isSameDay(d, normalized))) {
      return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE53935), width: 2),
        borderRadius: BorderRadius.circular(8),
      );
    }
    
    final color = _getDayColor(day);
    if (color != Colors.transparent) {
      return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      );
    }
    
    return const BoxDecoration();
  }

  TextStyle _getDayTextStyle(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    
    // Next period days - red text
    if (_nextPeriodDays.any((d) => isSameDay(d, normalized))) {
      return const TextStyle(
        color: Color(0xFFE53935),
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      );
    }
    
    // Period days - red text
    if (_periodDays.any((d) => isSameDay(d, normalized))) {
      return const TextStyle(
        color: Color(0xFFD32F2F),
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      );
    }
    
    // Ovulation day - white text on green
    if (_ovulationDay != null && isSameDay(normalized, _ovulationDay!)) {
      return const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      );
    }
    
    // Fertile window - dark teal text
    if (_fertileStart != null && _fertileEnd != null) {
      if ((normalized.isAfter(_fertileStart!) || isSameDay(normalized, _fertileStart!)) &&
          (normalized.isBefore(_fertileEnd!) || isSameDay(normalized, _fertileEnd!))) {
        return const TextStyle(
          color: Color(0xFF00695C),
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        );
      }
    }
    
    return const TextStyle(
      color: Colors.black87,
      fontFamily: 'Poppins',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E683D), Color(0xFF4CAF50)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  
                  // View mode toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildViewToggle('Week', CalendarFormat.week),
                        const SizedBox(width: 8),
                        _buildViewToggle('Month', CalendarFormat.month),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Calendar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isCalendarCollapsed ? 120 : (_calendarFormat == CalendarFormat.week ? 200 : 400),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: _focusedDay,
                      calendarFormat: _isCalendarCollapsed ? CalendarFormat.week : _calendarFormat,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        _togglePeriodDay(selectedDay);
                      },
                      onFormatChanged: (format) {
                        setState(() => _calendarFormat = format);
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        weekendTextStyle: const TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
                        defaultTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                        todayDecoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        todayTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                        weekendStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) => _buildCalendarDay(day),
                        todayBuilder: (context, day, focusedDay) => _buildCalendarDay(day, isToday: true),
                        selectedBuilder: (context, day, focusedDay) => _buildCalendarDay(day, isSelected: true),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Content below calendar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reminder Panel
                  if (_remindersInitialized)
                    ReminderPanel(reminderService: _reminderService),
                  
                  const SizedBox(height: 16),
                  
                  // Color Legend
                  _buildColorLegend(),
                  
                  const SizedBox(height: 24),
                  
                  // Logged Symptoms
                  const Text(
                    'Logged Symptoms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF2E683D),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSymptomsList(),
                  
                  const SizedBox(height: 24),
                  
                  // Log New Symptom Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) => const LogSymptomScreen(),
                        );
                        if (result == true) {
                          _fetchInsights();
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Log Symptom'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E683D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(String label, CalendarFormat format) {
    final isActive = _calendarFormat == format;
    return GestureDetector(
      onTap: () => setState(() => _calendarFormat = format),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF2E683D) : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarDay(DateTime day, {bool isToday = false, bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: _getDayDecoration(day),
      child: Center(
        child: Text(
          '${day.day}',
          style: _getDayTextStyle(day),
        ),
      ),
    );
  }

  Widget _buildColorLegend() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Legend',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 12),
            _buildLegendItem(const Color(0xFFFFCDD2), 'Period Days (Logged)', textColor: const Color(0xFFD32F2F)),
            _buildLegendItem(Colors.white, 'Next Period (Predicted)', border: const Color(0xFFE53935), textColor: const Color(0xFFE53935)),
            _buildLegendItem(const Color(0xFF4CAF50), 'Ovulation Day', textColor: Colors.white),
            _buildLegendItem(const Color(0xFF80CBC4), 'Fertile Window', textColor: const Color(0xFF00695C)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {Color? border, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              border: border != null ? Border.all(color: border, width: 2) : null,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: textColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_loggedSymptoms.isEmpty) {
      return const Text(
        'No symptoms logged yet',
        style: TextStyle(
          color: Colors.grey,
          fontStyle: FontStyle.italic,
          fontFamily: 'Poppins',
        ),
      );
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _loggedSymptoms.map((symptom) => Chip(
        label: Text(symptom),
        backgroundColor: const Color(0xFFE8F5E9),
        labelStyle: const TextStyle(
          color: Color(0xFF2E683D),
          fontFamily: 'Poppins',
        ),
      )).toList(),
    );
  }
}
