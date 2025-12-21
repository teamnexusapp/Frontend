import 'package:flutter/material.dart';
import '../../theme.dart';
import 'onboarding_5.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.calendar_today, size: 96, color: AppColors.primary),
                  SizedBox(height: 24),
                  Text('Track your cycle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Monitor your cycle with ease and get personalised insight',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size.fromHeight(48)),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Onboarding5())),
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
