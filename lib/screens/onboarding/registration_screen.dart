import '../../theme.dart';
import 'package:flutter/material.dart';
import 'verification_modal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _openVerification() {
    showDialog(
      context: context,
      builder: (_) => Dialog(child: VerificationModal(onVerify: (code) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verified: $code')));
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text('Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(controller: _fullName, decoration: const InputDecoration(labelText: 'Full Name :')),
                const SizedBox(height: 12),
                TextFormField(controller: _phone, decoration: const InputDecoration(labelText: 'Phone Number :'), keyboardType: TextInputType.phone),
                const SizedBox(height: 12),
                TextFormField(controller: _password, decoration: const InputDecoration(labelText: 'Password :'), obscureText: true),
                const SizedBox(height: 12),
                TextFormField(controller: _confirm, decoration: const InputDecoration(labelText: 'Confirm Password :'), obscureText: true),
                const SizedBox(height: 18),
                Center(child: Text('Sign up with', style: TextStyle(color: Colors.grey.shade600))),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.g_mobiledata, color: AppColors.primary)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? true) {
                        _openVerification();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



