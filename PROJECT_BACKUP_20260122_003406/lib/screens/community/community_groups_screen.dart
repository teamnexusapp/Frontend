import 'package:flutter/material.dart';
import '../../theme.dart';

class CommunityGroupsScreen extends StatelessWidget {
  const CommunityGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary, title: const Text('Community Groups', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: List.generate(4, (i) {
                return ListTile(
                  onTap: () => Navigator.of(context).pushNamed('/community_group'),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  title: const Text('Fertility Circle'),
                  subtitle: const Text('Weekly Visual meetups for emotional support'),
                  trailing: const Text('17 members'),
                );
              }),
            ),
          )
        ]),
      ),
    );
  }
}


