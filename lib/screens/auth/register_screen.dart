import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceImpl>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 8) ? 'Min 8 chars' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone (optional)'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _loading
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              setState(() => _loading = true);
                              try {
                                final user = await auth.signUpWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                );
                                if (user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Registered — verify OTP')), 
                                  );
                                  Navigator.pushReplacementNamed(context, '/profile');
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')));
                              } finally {
                                setState(() => _loading = false);
                              }
                            },
                            child: const Text('Register with Email'),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  final phone = _phoneController.text.trim();
                  if (phone.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter phone number')));
                    return;
                  }
                  setState(() => _loading = true);
                  try {
                    final user = await auth.signUpWithPhone(phoneNumber: phone);
                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Phone registered — verify OTP')),
                      );
                      Navigator.pushReplacementNamed(context, '/profile');
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  } finally {
                    setState(() => _loading = false);
                  }
                },
                child: const Text('Register with Phone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
