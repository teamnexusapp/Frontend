import 'package:flutter/material.dart';

class CommunityGroupsScreen extends StatelessWidget {
  static const routeName = '/community-groups';
  const CommunityGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Groups'),
        backgroundColor: const Color(0xFF2F6F3E),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: create group flow
            },
            child: const Text('Create Group', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: const Text('Fertility Circle', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Weekly virtual meetups for emotional support'),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => Navigator.pushNamed(context, '/community-group-display', arguments: {'id': i}),
              ),
            ),
          );
        },
      ),
    );
  }
}
