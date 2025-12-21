import 'package:flutter/material.dart';
import '../../theme.dart';
import 'onboarding_6.dart';

class Onboarding5 extends StatelessWidget {
  const Onboarding5({super.key});

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
                  Icon(Icons.book, size: 96, color: AppColors.primary),
                  SizedBox(height: 24),
                  Text('Learn in your own language', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Access fertility education and resources in the language you understand best',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size.fromHeight(48)),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Onboarding6())),
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
