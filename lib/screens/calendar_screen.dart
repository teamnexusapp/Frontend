import "package:flutter/material.dart";
import "package:table_calendar/table_calendar.dart";
import "../theme/app_theme.dart";

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock cycle data with green theme colors
  Map<DateTime, CycleDay> cycleData = {
    DateTime(DateTime.now().year, DateTime.now().month, 5): CycleDay(
      dayType: DayType.period,
      symptoms: ['Cramps', 'Fatigue'],
      color: Colors.red,
    ),
    DateTime(DateTime.now().year, DateTime.now().month, 12): CycleDay(
      dayType: DayType.fertile,
      symptoms: ['Increased discharge'],
      color: Colors.orange,
    ),
    DateTime(DateTime.now().year, DateTime.now().month, 14): CycleDay(
      dayType: DayType.ovulation,
      symptoms: ['Mittelschmerz'],
      color: Colors.pink,
    ),
    DateTime(DateTime.now().year, DateTime.now().month, 20): CycleDay(
      dayType: DayType.safe,
      symptoms: [],
      color: AppColors.primaryGreen,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertility Calendar"),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddEntryDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showDayDetails(selectedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.accentGreen.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(
                color: AppColors.darkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final cycleDay = cycleData[DateTime(date.year, date.month, date.day)];
                if (cycleDay != null) {
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cycleDay.color,
                    ),
                    width: 8,
                    height: 8,
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                LegendItem(color: Colors.red, label: 'Period'),
                LegendItem(color: Colors.orange, label: 'Fertile'),
                LegendItem(color: Colors.pink, label: 'Ovulation'),
                LegendItem(color: AppColors.primaryGreen, label: 'Safe'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDayDetails(DateTime date) {
    final cycleDay = cycleData[DateTime(date.year, date.month, date.day)];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Day Details - ${date.day}/${date.month}/${date.year}'),
        content: cycleDay != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Day Type: ${cycleDay.dayType.name}'),
                  const SizedBox(height: 10),
                  if (cycleDay.symptoms.isNotEmpty)
                    Text('Symptoms: ${cycleDay.symptoms.join(", ")}'),
                  if (cycleDay.notes.isNotEmpty)
                    Text('Notes: ${cycleDay.notes}'),
                ],
              )
            : const Text('No data logged for this day.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Entry', style: TextStyle(color: AppColors.darkGreen)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primaryGreen),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Select Day Type:'),
              Wrap(
                spacing: 8,
                children: DayType.values.map((type) {
                  return ChoiceChip(
                    label: Text(type.name),
                    selected: false,
                    onSelected: (selected) {},
                    backgroundColor: Colors.grey[200],
                    selectedColor: AppColors.primaryGreen,
                    labelStyle: const TextStyle(color: AppColors.darkGray),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.darkGray)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Save entry
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

enum DayType { period, fertile, ovulation, safe }

class CycleDay {
  final DayType dayType;
  final List<String> symptoms;
  final String notes;
  final Color color;

  CycleDay({
    required this.dayType,
    this.symptoms = const [],
    this.notes = '',
    required this.color,
  });
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.darkGray),
        ),
      ],
    );
  }
}
