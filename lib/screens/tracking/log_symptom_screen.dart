import 'package:flutter/material.dart';

class LogSymptomScreen extends StatefulWidget {
  const LogSymptomScreen({Key? key}) : super(key: key);

  @override
  State<LogSymptomScreen> createState() => _LogSymptomScreenState();
}

class _LogSymptomScreenState extends State<LogSymptomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Symptom'),
      ),
      body: const Center(
        child: Text('Symptom logging screen - Basic version'),
      ),
    );
  }
}
