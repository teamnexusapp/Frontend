import 'package:flutter/material.dart';
import '../services/notification_reminder_service.dart';

class ReminderPanel extends StatefulWidget {
  final NotificationReminderService reminderService;

  const ReminderPanel({
    super.key,
    required this.reminderService,
  });

  @override
  State<ReminderPanel> createState() => _ReminderPanelState();
}

class _ReminderPanelState extends State<ReminderPanel> {
  late Future<NotificationReminder?> _nextReminderFuture;

  @override
  void initState() {
    super.initState();
    _nextReminderFuture = widget.reminderService.getNextReminder();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificationReminder?>(
      future: _nextReminderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        final nextReminder = snapshot.data;
        if (nextReminder == null) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _getReminderColor(nextReminder.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getReminderColor(nextReminder.type),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getReminderIcon(nextReminder.type),
                    color: _getReminderColor(nextReminder.type),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nextReminder.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _getReminderColor(nextReminder.type),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Scheduled: ${_formatTime(nextReminder.scheduledTime)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                nextReminder.message,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                  fontFamily: 'Poppins',
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getReminderColor(String type) {
    switch (type) {
      case 'fertile_window':
        return const Color(0xFF2E683D);
      case 'symptom_log':
        return const Color(0xFF4CAF50);
      case 'period_log':
        return const Color(0xFFE91E63);
      default:
        return Colors.grey;
    }
  }

  IconData _getReminderIcon(String type) {
    switch (type) {
      case 'fertile_window':
        return Icons.favorite;
      case 'symptom_log':
        return Icons.checklist;
      case 'period_log':
        return Icons.calendar_today;
      default:
        return Icons.notifications;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays == 0) {
      return 'Today at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Tomorrow at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return 'In ${difference.inDays} days';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
