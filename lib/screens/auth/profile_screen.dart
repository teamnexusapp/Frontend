import 'package:flutter/material.dart';
import 'package:nexus_fertility_app/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder(
        future: authService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('No user found'));
          }
          
          final user = snapshot.data!;
          return ListView(
            children: [
              ListTile(
                title: const Text('Name'),
                subtitle: Text('${user.firstName} ${user.lastName}'),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
              ),
              // Add more profile fields as needed
            ],
          );
        },
      ),
    );
  }
}
