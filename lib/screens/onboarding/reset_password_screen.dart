import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email; // Optionally pass email or token if needed
  const ResetPasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}


class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  String? _token;

  @override
  void initState() {
    super.initState();
    // Extract token from URL query parameters
    final token = Uri.base.queryParameters['token'];
    setState(() {
      _token = token;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (_token == null || _token!.isEmpty) {
      setState(() { _error = 'Invalid or missing token.'; });
      return;
    }
    setState(() { _isLoading = true; _error = null; });
    try {
      await ApiService().resetPassword(token: _token!, newPassword: _passwordController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful!')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      setState(() { _error = 'Failed to reset password.'; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_error != null) ...[
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter new password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value != _passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _resetPassword,
                      child: const Text('Reset Password'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
