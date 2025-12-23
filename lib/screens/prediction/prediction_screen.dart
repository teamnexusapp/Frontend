import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  static const routeName = '/prediction';
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Minimal design matching the mock: white body, green header, result card
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction'),
        backgroundColor: const Color(0xFF2F6F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Text('Prediction result', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text('This is a placeholder for prediction outputs.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F6F3E)),
              onPressed: () {},
              child: const Text('Run Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}
