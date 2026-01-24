import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? token;
  const ResetPasswordScreen({Key? key, this.token}) : super(key: key);

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
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _token = widget.token;
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
      Navigator.of(context).pushReplacementNamed('/password-updated');
    } catch (e) {
      setState(() { _error = 'Failed to reset password.'; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2E683D)),
        title: const Text('Reset Password', style: TextStyle(color: Color(0xFF2E683D), fontWeight: FontWeight.w600)),
      ),
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
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: const TextStyle(color: Color(0xFF2E683D)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E683D)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E683D), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFF2E683D),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter new password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Color(0xFF2E683D)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E683D)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF2E683D), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFF2E683D),
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF2E683D))
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E683D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _resetPassword,
                        child: const Text('Reset Password', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
