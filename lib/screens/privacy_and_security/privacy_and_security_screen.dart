import 'package:flutter/material.dart';

class PrivacyAndSecurityScreen extends StatelessWidget {
  static const routeName = '/privacy-and-security';
  const PrivacyAndSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: const Color(0xFF2F6F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('Terms & privacy information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Last updated: December 18, 2025'),
            SizedBox(height: 12),
            Text(
              'Please read these Terms and Conditions carefully before using the app. '
              'This is placeholder text. Replace with real privacy and security policy text.',
            ),
          ],
        ),
      ),
    );
  }
}
