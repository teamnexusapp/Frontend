import 'package:flutter/material.dart';
import '../../widgets/swipeable_green_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Period Calendar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2E683D),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SwipeableGreenCalendar(
                initialMonth: DateTime.now(),
                selectedDates: const <DateTime>{},
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Predicted: Next period starts Dec 28',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

}
