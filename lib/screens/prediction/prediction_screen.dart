import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prediction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              onPressed: () {},
              child: const Text('Run Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}

import '../../theme.dart';

