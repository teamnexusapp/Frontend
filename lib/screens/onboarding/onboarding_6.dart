import 'package:flutter/material.dart';
import '../../theme.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';

class Onboarding6 extends StatelessWidget {
  const Onboarding6({super.key});

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
                  Icon(Icons.favorite, size: 96, color: AppColors.primary),
                  SizedBox(height: 24),
                  Text('Feel supported', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      'Join a caring community and get the support you need on your journey',
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
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RegistrationScreen())),
                  child: const Text('Get Started'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
