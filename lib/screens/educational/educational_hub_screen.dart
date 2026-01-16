import 'package:flutter/material.dart';
import '../../theme.dart';

class EducationalHubScreen extends StatelessWidget {
  const EducationalHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Educational Hub', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fertility Basics', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Infertility isn\'t a curse - educational article preview...'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Fertility Basics'),
              subtitle: const Text('5 mins read'),
              onTap: () => Navigator.of(context).pushNamed('/educational'),
            ),
          ],
        ),
      ),
    );
  }
}
