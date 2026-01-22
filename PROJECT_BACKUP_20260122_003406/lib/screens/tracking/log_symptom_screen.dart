import '../../services/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';

class LogSymptomScreen extends StatefulWidget {
  const LogSymptomScreen({Key? key}) : super(key: key);

  @override
  _LogSymptomScreenState createState() => _LogSymptomScreenState();
}

class _LogSymptomScreenState extends State<LogSymptomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Symptoms'),
      ),
      body: Center(
        child: Text('Log Symptom Screen - Under Construction'),
      ),
    );
  }
}



