import 'package:flutter/material.dart';

class CommunityGroupDisplayScreen extends StatelessWidget {
  static const routeName = '/community-group-display';
  const CommunityGroupDisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final id = args != null && args['id'] != null ? args['id'] : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Description'),
        backgroundColor: const Color(0xFF2F6F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fertility Circle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Description:'),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Connect with others who understand your journey. Join support groups for encouragement and shared experiences. (Placeholder description)',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Members:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: List.generate(5, (i) {
                  return ListTile(
                    leading: CircleAvatar(child: Text('G')),
                    title: Text('Member $i'),
                  );
                }),
              ),
            ),
            // Composer / message area placeholder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration.collapsed(hintText: 'Type message...'))),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
