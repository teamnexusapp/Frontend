import 'package:flutter/material.dart';
import 'login_screen.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

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
                const Text(
                  'Password Updated',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF2E683D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Icon(
                  Icons.check_circle,
                  size: 72,
                  color: Color(0xFF2E683D),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your password has been successfully updated. You can now log in with your new credentials.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 360,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E683D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
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
