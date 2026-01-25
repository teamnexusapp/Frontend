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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    final phoneRegex = RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceImpl>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false),
        ),
      ),
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
                validator: _validateEmail,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: 'Min 8 characters, 1 uppercase, 1 number',
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone (optional)'),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
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
                                  Navigator.pushReplacementNamed(context, '/login');
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
                      Navigator.pushReplacementNamed(context, '/login');
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
