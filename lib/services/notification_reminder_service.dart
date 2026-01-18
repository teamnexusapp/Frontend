import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationReminder {
  final String id;
  final String title;
  final String message;
  final DateTime scheduledTime;
  final String type; // 'fertile_window', 'symptom_log', 'period_log'
  bool isSent;

  NotificationReminder({
    required this.id,
    required this.title,
    required this.message,
    required this.scheduledTime,
    required this.type,
    this.isSent = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'scheduledTime': scheduledTime.toIso8601String(),
      'type': type,
      'isSent': isSent,
    };
  }

  factory NotificationReminder.fromJson(Map<String, dynamic> json) {
    return NotificationReminder(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      scheduledTime: DateTime.parse(json['scheduledTime']),
      type: json['type'],
      isSent: json['isSent'] ?? false,
    );
  }
}

class NotificationReminderService {
  static const String _remindersKey = 'fertility_reminders';
  static const String _settingsKey = 'reminder_settings';
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Enable/disable notification types
  Future<void> setReminderEnabled(String type, bool enabled) async {
    final settings = await getReminderSettings();
    settings[type] = enabled;
    await _prefs.setString(_settingsKey, jsonEncode(settings));
  }

  Future<Map<String, dynamic>> getReminderSettings() async {
    final settingsJson = _prefs.getString(_settingsKey);
    if (settingsJson == null) {
      // Default settings
      return {
        'fertile_window': true,
        'symptom_log': true,
        'period_log': true,
      };
    }
    return jsonDecode(settingsJson);
  }

  // Schedule fertile window reminders
  Future<void> scheduleFertileWindowReminders(
    DateTime cycleStartDate,
    int cycleLength,
  ) async {
    final settings = await getReminderSettings();
    if (settings['fertile_window'] != true) return;

    // Calculate fertile window (typically days 12-16 of cycle)
    final fertileStart = cycleStartDate.add(const Duration(days: 11));
    final fertileEnd = cycleStartDate.add(const Duration(days: 16));

    final reminders = <NotificationReminder>[];

    // Morning reminder on fertile window start
    reminders.add(
      NotificationReminder(
        id: 'fertile_start_${cycleStartDate.millisecondsSinceEpoch}',
        title: 'Your Fertile Window Begins',
        message: 'Your most fertile days are here. If you\'re trying to conceive, now is the best time to try. Stay hydrated and take care of yourself!',
        scheduledTime: DateTime(
          fertileStart.year,
          fertileStart.month,
          fertileStart.day,
          8,
          0,
        ),
        type: 'fertile_window',
      ),
    );

    // Midday reminder during fertile window
    reminders.add(
      NotificationReminder(
        id: 'fertile_midday_${cycleStartDate.millisecondsSinceEpoch}',
        title: 'Fertile Window: Midday Reminder',
        message: 'Remember to track any changes in cervical mucus or basal body temperature. Every detail helps!',
        scheduledTime: DateTime(
          fertileStart.year,
          fertileStart.month,
          (fertileStart.day + fertileEnd.day) ~/ 2,
          12,
          0,
        ),
        type: 'fertile_window',
      ),
    );

    // End of fertile window reminder
    reminders.add(
      NotificationReminder(
        id: 'fertile_end_${cycleStartDate.millisecondsSinceEpoch}',
        title: 'Your Fertile Window Ends',
        message: 'Your fertile window is ending. Review your cycle data and plan for next month.',
        scheduledTime: DateTime(
          fertileEnd.year,
          fertileEnd.month,
          fertileEnd.day,
          20,
          0,
        ),
        type: 'fertile_window',
      ),
    );

    await _saveReminders(reminders);
  }

  // Schedule daily symptom logging reminders
  Future<void> scheduleSymptomLoggingReminders(
    DateTime cycleStartDate,
    int cycleLength,
  ) async {
    final settings = await getReminderSettings();
    if (settings['symptom_log'] != true) return;

    final reminders = <NotificationReminder>[];

    // Daily symptom log reminders (afternoon at 3 PM for 7 days of cycle)
    for (int i = 0; i < 7; i++) {
      final date = cycleStartDate.add(Duration(days: i));
      reminders.add(
        NotificationReminder(
          id: 'symptom_log_day${i}_${cycleStartDate.millisecondsSinceEpoch}',
          title: 'Time to Log Your Symptoms',
          message: 'How are you feeling today? Log your symptoms to get better insights about your cycle patterns.',
          scheduledTime: DateTime(date.year, date.month, date.day, 15, 0),
          type: 'symptom_log',
        ),
      );
    }

    await _saveReminders(reminders);
  }

  // Schedule period logging reminders
  Future<void> schedulePeriodLoggingReminders(
    DateTime lastPeriodDate,
    int averageCycleLength,
  ) async {
    final settings = await getReminderSettings();
    if (settings['period_log'] != true) return;

    final reminders = <NotificationReminder>[];

    // Reminder a few days before expected period
    final expectedPeriod = lastPeriodDate.add(Duration(days: averageCycleLength));
    final preReminderDate = expectedPeriod.subtract(const Duration(days: 3));

    reminders.add(
      NotificationReminder(
        id: 'period_log_pre_${lastPeriodDate.millisecondsSinceEpoch}',
        title: 'Period Coming Soon',
        message: 'Your period is expected in a few days. Be prepared and log when it starts.',
        scheduledTime: DateTime(
          preReminderDate.year,
          preReminderDate.month,
          preReminderDate.day,
          9,
          0,
        ),
        type: 'period_log',
      ),
    );

    // Reminder on expected period date
    reminders.add(
      NotificationReminder(
        id: 'period_log_expected_${lastPeriodDate.millisecondsSinceEpoch}',
        title: 'Log Your Period',
        message: 'If your period has started, please log it in the app to keep your cycle tracking accurate.',
        scheduledTime: DateTime(
          expectedPeriod.year,
          expectedPeriod.month,
          expectedPeriod.day,
          8,
          0,
        ),
        type: 'period_log',
      ),
    );

    // Reminder a week after expected period if not logged
    final overduReminderDate = expectedPeriod.add(const Duration(days: 7));
    reminders.add(
      NotificationReminder(
        id: 'period_log_overdue_${lastPeriodDate.millisecondsSinceEpoch}',
        title: 'Update Your Period Log',
        message: 'Haven\'t logged your period yet? Update your cycle information for accurate tracking.',
        scheduledTime: DateTime(
          overduReminderDate.year,
          overduReminderDate.month,
          overduReminderDate.day,
          10,
          0,
        ),
        type: 'period_log',
      ),
    );

    await _saveReminders(reminders);
  }

  // Get all pending reminders
  Future<List<NotificationReminder>> getPendingReminders() async {
    final reminders = await getAllReminders();
    final now = DateTime.now();
    
    return reminders
        .where((r) => r.scheduledTime.isAfter(now) && !r.isSent)
        .toList();
  }

  // Get reminders for a specific type
  Future<List<NotificationReminder>> getRemindersByType(String type) async {
    final reminders = await getAllReminders();
    return reminders.where((r) => r.type == type).toList();
  }

  // Mark reminder as sent
  Future<void> markReminderAsSent(String reminderId) async {
    final reminders = await getAllReminders();
    final index = reminders.indexWhere((r) => r.id == reminderId);
    if (index != -1) {
      reminders[index].isSent = true;
      await _saveReminders(reminders);
    }
  }

  // Save all reminders
  Future<void> _saveReminders(List<NotificationReminder> reminders) async {
    final existingReminders = await getAllReminders();
    final Map<String, NotificationReminder> reminderMap = {};

    // Add existing reminders
    for (var reminder in existingReminders) {
      reminderMap[reminder.id] = reminder;
    }

    // Add or update new reminders
    for (var reminder in reminders) {
      reminderMap[reminder.id] = reminder;
    }

    final jsonList = reminderMap.values.map((r) => r.toJson()).toList();
    await _prefs.setString(_remindersKey, jsonEncode(jsonList));
  }

  // Get all reminders
  Future<List<NotificationReminder>> getAllReminders() async {
    final remindersJson = _prefs.getString(_remindersKey);
    if (remindersJson == null) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(remindersJson);
    return decoded.map((item) => NotificationReminder.fromJson(item)).toList();
  }

  // Delete a reminder
  Future<void> deleteReminder(String reminderId) async {
    final reminders = await getAllReminders();
    reminders.removeWhere((r) => r.id == reminderId);
    await _saveReminders(reminders);
  }

  // Clear all reminders
  Future<void> clearAllReminders() async {
    await _prefs.remove(_remindersKey);
  }

  // Get next upcoming reminder
  Future<NotificationReminder?> getNextReminder() async {
    final pending = await getPendingReminders();
    if (pending.isEmpty) return null;
    
    pending.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return pending.first;
  }
}
