import 'package:flutter/material.dart';

class SettingsProfileSetupScreen extends StatelessWidget {
  static const routeName = '/profile-setup';
  const SettingsProfileSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A simple form-like layout matching the mockup
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        backgroundColor: const Color(0xFF2F6F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 12),
            TextFormField(decoration: const InputDecoration(labelText: 'Email Address')),
            const SizedBox(height: 12),
            TextFormField(obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 12),
            TextFormField(decoration: const InputDecoration(labelText: 'Profile Picture (upload)')),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('Christian')),
                Chip(label: Text('Muslim')),
                Chip(label: Text('None')),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F6F3E)),
              onPressed: () {},
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
