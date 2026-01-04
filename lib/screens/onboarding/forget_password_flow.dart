import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _linkSent = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.alternate_email,
                  size: 72,
                  color: Color(0xFF2E683D),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Send password reset link',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Enter your account email. We will send you a secure link to reset your password.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildEmailField(),
                const SizedBox(height: 20),
                SizedBox(
                  width: 315,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _handleSendLink,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E683D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: _isSending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send Link',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_linkSent)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check, color: Color(0xFF2E683D), size: 16),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'We emailed you a secure reset link. Open it to continue.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                if (_linkSent) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/reset-password');
                    },
                    child: const Text(
                      'I have the token — reset now',
                      style: TextStyle(
                        color: Color(0xFF2E683D),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Email address',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Color(0xFF2E683D),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 360,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              hintText: 'you@example.com',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontFamily: 'Poppins',
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSendLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email to continue.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      // Use the backend domain for the reset link
      // Backend will send: https://fertipath.onrender.com/reset_password?token=ABC123
      final resetUrl = 'https://fertipath.onrender.com/reset_password';
      
      await ApiService().forgotPassword(
        email: email,
        redirectUrl: resetUrl,
      );

      if (!mounted) return;
      setState(() {
        _linkSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('We sent a secure reset link to $email.'),
          backgroundColor: const Color(0xFF2E683D),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send link: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }
}

