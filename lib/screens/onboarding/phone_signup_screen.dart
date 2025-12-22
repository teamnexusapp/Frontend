import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/localization_provider.dart' as loc_provider;
import 'onboarding_screens.dart';
import 'login_screen.dart';

class PhoneSignupScreen extends StatefulWidget {
  const PhoneSignupScreen({super.key});

  @override
  State<PhoneSignupScreen> createState() => _PhoneSignupScreenState();
}

class _PhoneSignupScreenState extends State<PhoneSignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showVerifyModal() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Get the selected language from LocalizationProvider
    final localizationProvider = context.read<loc_provider.LocalizationProvider>();
    final selectedLanguage =
        (localizationProvider.selectedLanguageCode ?? 'en').toLowerCase();

    // Parse full name into first and last name
    final nameParts = _fullNameController.text.trim().split(' ');
    final firstName = nameParts.first;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : nameParts.first;

    // Use provided username
    final username = _usernameController.text.trim();

    // Register and send OTP before showing modal
    try {
      final authService = context.read<AuthService>();
      
      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sending verification code...'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      await authService.signUpWithPhone(
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        username: username.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        password: _passwordController.text,
        preferredLanguage: selectedLanguage,
      );

      if (!mounted) return;

      // OTP sent successfully, show verification modal
      final otp1Controller = TextEditingController();
      final otp2Controller = TextEditingController();
      final otp3Controller = TextEditingController();
      final otp4Controller = TextEditingController();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _VerifyModalContent(
            otp1Controller: otp1Controller,
            otp2Controller: otp2Controller,
            otp3Controller: otp3Controller,
            otp4Controller: otp4Controller,
            phoneNumber: _phoneController.text,
            email: _emailController.text,
            firstName: firstName,
            lastName: lastName,
            password: _passwordController.text,
            selectedLanguage: selectedLanguage,
          );
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send verification code: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  
                  // Register Title
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF2E683D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Full Name Field
                  _buildInputField(
                    label: 'Full Name',
                    controller: _fullNameController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 5),

                  // Email Field
                  _buildInputField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 5),

                  // Username Field
                  _buildInputField(
                    label: 'Username',
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 5),

                  // Phone Number Field
                  _buildInputField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 5),

                  // Password Field
                  _buildInputField(
                    label: 'Password',
                    controller: _passwordController,
                    isPassword: true,
                    showPassword: _showPassword,
                    onToggleVisibility: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 5),

                  // Confirm Password Field
                  _buildInputField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    isPassword: true,
                    showPassword: _showConfirmPassword,
                    onToggleVisibility: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Sign up with text
                  const Text(
                    'Sign up with',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Social Sign-in Circles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialCircle('G'),
                      const SizedBox(width: 10),
                      _buildSocialCircle('f'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _showVerifyModal,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E683D),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Cancel Button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const OnboardingScreens(),
                        ),
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Color(0xFF2E683D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool showPassword = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Color(0xFF2E683D),
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
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword && !showPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontFamily: 'Poppins',
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF2E683D),
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
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

  Widget _buildSocialCircle(String text) {
    return Container(
      width: 50,
      height: 47,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Color(0xFF2E683D),
          ),
        ),
      ),
    );
  }
}

class _VerifyModalContent extends StatefulWidget {
  final TextEditingController otp1Controller;
  final TextEditingController otp2Controller;
  final TextEditingController otp3Controller;
  final TextEditingController otp4Controller;
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String selectedLanguage;

  const _VerifyModalContent({
    required this.otp1Controller,
    required this.otp2Controller,
    required this.otp3Controller,
    required this.otp4Controller,
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.selectedLanguage,
  });

  @override
  State<_VerifyModalContent> createState() => _VerifyModalContentState();
}

class _VerifyModalContentState extends State<_VerifyModalContent> {
  int secondsRemaining = 180;
  bool timerStarted = false;

  @override
  void initState() {
    super.initState();
    // Start timer when widget is initialized
    Future.delayed(const Duration(milliseconds: 100), () {
      _startTimer();
    });
  }

  void _startTimer() {
    if (timerStarted) return;
    timerStarted = true;
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
        timerStarted = false;
        _startTimer();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      secondsRemaining = 180;
      timerStarted = false;
    });
    _startTimer();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 72,
                  color: Color(0xFF2E683D),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verify Your Account',
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
                  'A verification code has been sent to your email. Please enter it to continue.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // OTP Input Fields - 4 digits
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOTPField(widget.otp1Controller),
                    const SizedBox(width: 8),
                    _buildOTPField(widget.otp2Controller),
                    const SizedBox(width: 8),
                    _buildOTPField(widget.otp3Controller),
                    const SizedBox(width: 8),
                    _buildOTPField(widget.otp4Controller),
                  ],
                ),
                const SizedBox(height: 12),
                // Resend and Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: secondsRemaining == 0 ? _resetTimer : null,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: secondsRemaining == 0
                              ? const Color(0xFF2E683D)
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _formatTime(secondsRemaining),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Color(0xFF2E683D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 315,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Get OTP from controllers
                      final otp = widget.otp1Controller.text +
                          widget.otp2Controller.text +
                          widget.otp3Controller.text +
                          widget.otp4Controller.text;

                      if (otp.length == 4) {
                        try {
                          // Verify OTP (signup was already called when modal opened)
                          final authService = context.read<AuthService>();
                          
                          await authService.verifyPhoneOTP(
                            phoneNumber: widget.phoneNumber,
                            otp: otp,
                          );

                          if (mounted) {
                            Navigator.of(context).pop();
                            // Navigate to login screen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Verification failed: ${e.toString()}'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter complete OTP'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
                      'Verify',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPField(TextEditingController controller) {
    return Container(
      width: 60,
      height: 66,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFA8D497),
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: Color(0xFF2E683D),
        ),
      ),
    );
  }
}
