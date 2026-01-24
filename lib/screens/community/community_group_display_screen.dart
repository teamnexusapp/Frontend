import 'package:flutter/material.dart';
import '../../theme.dart';

class CommunityGroupDisplayScreen extends StatelessWidget {
  const CommunityGroupDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('Fertility Circle', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Connect with others who understand your journey. Join support groups for encouragement and shared experiences.'),
                SizedBox(height: 12),
                ListTile(leading: CircleAvatar(child: Text('A')), title: Text('ADMIN'), subtitle: Text('Connect with others who understand your journey.')),
                Divider(),
                ListTile(leading: CircleAvatar(child: Text('G')), title: Text('Gloria'), subtitle: Text('Connect with others who understand your journey.')),
              ]),
            ),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children: [const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type a message...'))), IconButton(onPressed: () {}, icon: const Icon(Icons.send))])),
          ],
        ),
      ),
    );
  }
}
