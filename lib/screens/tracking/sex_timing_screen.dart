import 'package:flutter/material.dart';

class SexTimingPreferencesScreen extends StatelessWidget {
  const SexTimingPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sex Timing Preferences')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preferences for timing sex relative to fertility window', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}