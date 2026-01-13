<<<<<<< HEAD
﻿import 'package:flutter/material.dart';

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
=======
import 'package:flutter/material.dart';
import '../../theme.dart';

class GoalsUpdateScreen extends StatelessWidget {
  const GoalsUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('Update Goals', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Start Date'),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(hintText: '15/06/2025')),
            const SizedBox(height: 12),
            const Text('Primary Goal'),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(hintText: 'Conceive')),
            const SizedBox(height: 12),
            const Text('Cycle Length'),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(hintText: '28')),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Update')))
          ]),
>>>>>>> origin/main
        ),
      ),
    );
  }
}
