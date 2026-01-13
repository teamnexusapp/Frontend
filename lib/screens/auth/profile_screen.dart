import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loading = false;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceImpl>(context);
    final user = auth.currentUser;

    if (user != null) {
      _firstName.text = user.firstName ?? '';
      _lastName.text = user.lastName ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? const Center(child: Text('No user'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  const SizedBox(height: 8),
                  Text('Phone: ${user.phoneNumber ?? '—'}'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _firstName,
                    decoration: const InputDecoration(labelText: 'First name'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _lastName,
                    decoration: const InputDecoration(labelText: 'Last name'),
                  ),
                  const SizedBox(height: 16),
                  _loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() => _loading = true);
                            try {
                              final updated = await auth.updateUserProfile(
                                userId: user.id ?? '',
                                firstName: _firstName.text.trim().isEmpty ? null : _firstName.text.trim(),
                                lastName: _lastName.text.trim().isEmpty ? null : _lastName.text.trim(),
                              );
                              if (updated != null) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                            } finally {
                              setState(() => _loading = false);
                            }
                          },
                          child: const Text('Save'),
                        ),
                ],
              ),
      ),
    );
  }
}
