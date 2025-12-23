import 'package:flutter/material.dart';

class GoalsUpdateScreen extends StatelessWidget {
  static const routeName = '/goals-update';
  const GoalsUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Goals'),
        backgroundColor: const Color(0xFF2F6F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(decoration: inputDecoration.copyWith(labelText: 'Start Date')),
            const SizedBox(height: 12),
            TextFormField(decoration: inputDecoration.copyWith(labelText: 'Primary Goal')),
            const SizedBox(height: 12),
            TextFormField(decoration: inputDecoration.copyWith(labelText: 'Cycle Length')),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F6F3E)),
              onPressed: () {},
              child: const SizedBox(width: double.infinity, child: Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Update'),
              ))),
            ),
          ],
        ),
      ),
    );
  }
}
