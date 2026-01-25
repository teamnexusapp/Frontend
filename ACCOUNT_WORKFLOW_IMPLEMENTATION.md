# Account Workflow Implementation Guide

## Overview
This guide provides practical implementation details for the Nexus Fertility App's account creation workflow, including code examples and integration points.

---

## Table of Contents
1. [Setup & Configuration](#setup--configuration)
2. [Email Signup Implementation](#email-signup-implementation)
3. [Phone Signup Implementation](#phone-signup-implementation)
4. [OTP Verification](#otp-verification)
5. [Profile Setup Implementation](#profile-setup-implementation)
6. [Integration Points](#integration-points)
7. [Testing](#testing)

---

## Setup & Configuration

### 1. Dependencies

Add these to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  email_validator: ^2.1.17
  http: ^1.1.2
  intl: ^0.20.2
```

### 2. Environment Variables

Create `lib/config/app_config.dart`:

```dart
class AppConfig {
  static const String apiBaseUrl = 'https://api.nexusfertility.com';
  static const String apiVersion = '/v1';
  
  // Auth endpoints
  static const String signUpEmailEndpoint = '$apiBaseUrl$apiVersion/auth/signup/email';
  static const String signUpPhoneEndpoint = '$apiBaseUrl$apiVersion/auth/signup/phone';
  static const String verifyOtpEndpoint = '$apiBaseUrl$apiVersion/auth/verify-otp';
  static const String resendOtpEndpoint = '$apiBaseUrl$apiVersion/auth/resend-otp';
  static const String updateProfileEndpoint = '$apiBaseUrl$apiVersion/user/profile';
  
  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration otpExpiration = Duration(minutes: 10);
  static const int maxOtpResendAttempts = 3;
}
```

### 3. Routes Configuration

Update `lib/main.dart`:

```dart
MaterialApp(
  routes: {
    '/': (context) => const SplashScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/language': (context) => const LanguageSelectionScreen(),
    '/account-type': (context) => const AccountTypeSelectionScreen(),
    '/signup-email': (context) => const EmailSignupScreen(),
    '/signup-phone': (context) => const PhoneSignupScreen(),
    '/profile-setup': (context) => const ProfileSetupScreen(),
    '/home': (context) => const HomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
  },
)
```

---

## Email Signup Implementation

### Complete EmailSignupScreen Flow

**File**: `lib/screens/onboarding/email_signup_screen.dart`

The email signup screen handles:
- Form validation
- User creation via AuthService
- Error handling
- Navigation to profile setup

**Key Features**:
- Email validation using `email_validator` package
- Password strength validation
- Password confirmation matching
- Terms & conditions acceptance
- Loading state management

### AuthService Integration

```dart
// In AuthService
Future<User?> signUpWithEmail({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String username,
}) async {
  try {
    // 1. Validate input
    if (!EmailValidator.validate(email)) {
      throw AuthException('Invalid email format');
    }
    
    // 2. Check if email exists
    final emailExists = await _checkEmailExists(email);
    if (emailExists) {
      throw AuthException('Email already registered');
    }
    
    // 3. Check if username exists
    final usernameExists = await _checkUsernameExists(username);
    if (usernameExists) {
      throw AuthException('Username already taken');
    }
    
    // 4. Create user account
    final response = await _apiService.post(
      AppConfig.signUpEmailEndpoint,
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
      },
    ).timeout(AppConfig.requestTimeout);
    
    if (response.statusCode == 201) {
      final userData = User.fromJson(jsonDecode(response.body));
      
      // 5. Store user locally
      await _saveUserToPrefs(userData);
      
      // 6. Update current user
      _currentUser = userData;
      notifyListeners();
      
      return userData;
    } else {
      throw AuthException('Failed to create account');
    }
  } catch (e) {
    rethrow;
  }
}

Future<bool> _checkEmailExists(String email) async {
  try {
    final response = await _apiService.get(
      '${AppConfig.apiBaseUrl}${AppConfig.apiVersion}/auth/check-email',
      queryParameters: {'email': email},
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<bool> _checkUsernameExists(String username) async {
  try {
    final response = await _apiService.get(
      '${AppConfig.apiBaseUrl}${AppConfig.apiVersion}/auth/check-username',
      queryParameters: {'username': username},
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
```

---

## Phone Signup Implementation

### PhoneSignupScreen Flow

**File**: `lib/screens/onboarding/phone_signup_screen.dart`

The phone signup screen:
1. Collects user information
2. Initiates phone number verification
3. Shows OTP verification modal
4. Verifies OTP with backend
5. Creates account upon successful verification

### Phone Signup AuthService Method

```dart
Future<User?> signUpWithPhone({
  required String phoneNumber,
  String? email,
  String? username,
  String? firstName,
  String? lastName,
  String? password,
  String? preferredLanguage,
}) async {
  try {
    // 1. Validate phone number
    if (!_isValidPhoneNumber(phoneNumber)) {
      throw AuthException('Invalid phone number format');
    }
    
    // 2. Check if phone exists
    final phoneExists = await _checkPhoneExists(phoneNumber);
    if (phoneExists) {
      throw AuthException('Phone number already registered');
    }
    
    // 3. Request OTP
    final otpResponse = await _apiService.post(
      AppConfig.signUpPhoneEndpoint,
      body: {
        'phoneNumber': phoneNumber,
        'email': email,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'preferredLanguage': preferredLanguage,
      },
    ).timeout(AppConfig.requestTimeout);
    
    if (otpResponse.statusCode == 200) {
      // OTP sent successfully
      _phoneNumberPendingVerification = phoneNumber;
      _otpSentTime = DateTime.now();
      return null; // Return null until OTP verified
    } else {
      throw AuthException('Failed to send OTP');
    }
  } catch (e) {
    rethrow;
  }
}

bool _isValidPhoneNumber(String phone) {
  // Remove all non-numeric characters
  final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
  
  // Check if it starts with + and has 10-14 digits
  if (cleaned.startsWith('+')) {
    return RegExp(r'^\+\d{10,14}$').hasMatch(cleaned);
  }
  
  // Or if it's 10-11 digits (local format)
  return RegExp(r'^\d{10,11}$').hasMatch(cleaned);
}

Future<bool> _checkPhoneExists(String phone) async {
  try {
    final response = await _apiService.get(
      '${AppConfig.apiBaseUrl}${AppConfig.apiVersion}/auth/check-phone',
      queryParameters: {'phone': phone},
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
```

---

## OTP Verification

### OTP Modal Component

**File**: `lib/screens/onboarding/phone_signup_screen.dart`

```dart
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
  late Timer _timer;
  int _secondsRemaining = 300; // 5 minutes
  bool _isVerifying = false;
  int _resendAttempts = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  Future<void> _verifyOtp() async {
    final otp = widget.otp1Controller.text +
        widget.otp2Controller.text +
        widget.otp3Controller.text +
        widget.otp4Controller.text;

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete OTP')),
      );
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final authService = context.read<AuthService>();
      
      final user = await authService.verifyPhoneOTP(
        widget.phoneNumber,
        otp,
      );

      if (!mounted) return;

      if (user != null) {
        // OTP verified successfully, close modal and proceed
        Navigator.of(context).pop();
        
        // Show success and navigate to profile setup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone verified successfully!')),
        );
        
        Navigator.of(context).pushReplacementNamed('/profile-setup');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_resendAttempts >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum resend attempts reached'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final authService = context.read<AuthService>();
      await authService.resendPhoneOTP(widget.phoneNumber);
      
      setState(() {
        _secondsRemaining = 300;
        _resendAttempts++;
      });
      
      _startTimer();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP resent successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verify Your Phone'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter the 4-digit code sent to your phone'),
          const SizedBox(height: 20),
          
          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOtpField(widget.otp1Controller),
              _buildOtpField(widget.otp2Controller),
              _buildOtpField(widget.otp3Controller),
              _buildOtpField(widget.otp4Controller),
            ],
          ),
          const SizedBox(height: 20),
          
          // Timer
          Text(
            'Code expires in: ${_formatTime(_secondsRemaining)}',
            style: TextStyle(
              fontSize: 14,
              color: _secondsRemaining < 60 ? Colors.red : Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          
          // Verify Button
          ElevatedButton(
            onPressed: _isVerifying ? null : _verifyOtp,
            child: _isVerifying
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Verify OTP'),
          ),
          const SizedBox(height: 10),
          
          // Resend Button
          TextButton(
            onPressed: _resendAttempts >= 3 ? null : _resendOtp,
            child: Text(
              'Resend OTP (${3 - _resendAttempts} attempts left)',
              style: TextStyle(
                color: _resendAttempts >= 3 ? Colors.grey : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && controller != widget.otp4Controller) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
```

### OTP Verification in AuthService

```dart
Future<User?> verifyPhoneOTP(String phoneNumber, String otp) async {
  try {
    final response = await _apiService.post(
      AppConfig.verifyOtpEndpoint,
      body: {
        'phoneNumber': phoneNumber,
        'otp': otp,
      },
    ).timeout(AppConfig.requestTimeout);

    if (response.statusCode == 200) {
      final userData = User.fromJson(jsonDecode(response.body));
      
      // Save user locally
      await _saveUserToPrefs(userData);
      
      // Update current user
      _currentUser = userData;
      notifyListeners();
      
      return userData;
    } else {
      throw AuthException('OTP verification failed');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> resendPhoneOTP(String phoneNumber) async {
  try {
    final response = await _apiService.post(
      AppConfig.resendOtpEndpoint,
      body: {
        'phoneNumber': phoneNumber,
      },
    ).timeout(AppConfig.requestTimeout);

    if (response.statusCode != 200) {
      throw AuthException('Failed to resend OTP');
    }
  } catch (e) {
    rethrow;
  }
}
```

---

## Profile Setup Implementation

### ProfileSetupScreen Complete Flow

**File**: `lib/screens/onboarding/profile_setup_screen.dart`

The profile setup screen collects:
1. Health metrics (age, cycle length, period length)
2. Last period date
3. TTC history
4. Faith preference
5. Language preference
6. Audio guidance preference
7. Terms acceptance

### Submission Logic

```dart
Future<void> _submitProfile() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (!_acceptTerms) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please accept terms and conditions')),
    );
    return;
  }

  setState(() => _isLoading = true);

  try {
    final authService = context.read<AuthService>();
    
    final profileData = {
      'age': _age,
      'cycleLength': _cycleLength,
      'periodLength': _periodLength,
      'lastPeriodDate': _lastPeriodDate?.toIso8601String(),
      'ttcHistory': _ttcHistory,
      'faithPreference': _faithPreference,
      'language': _language,
      'audioGuidance': _audioGuidance,
      'termsAccepted': true,
      'profileCompletedAt': DateTime.now().toIso8601String(),
    };

    await authService.updateUserProfile(profileData);

    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile setup complete!')),
    );

    // Navigate to home
    Navigator.of(context).pushReplacementNamed('/home');
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

### updateUserProfile Implementation

```dart
Future<void> updateUserProfile(Map<String, dynamic> updates) async {
  try {
    if (_currentUser == null) {
      throw AuthException('No user logged in');
    }

    final response = await _apiService.put(
      '${AppConfig.updateProfileEndpoint}/${_currentUser!.id}',
      body: updates,
    ).timeout(AppConfig.requestTimeout);

    if (response.statusCode == 200) {
      final userData = User.fromJson(jsonDecode(response.body));
      
      // Update local user object
      _currentUser = userData;
      
      // Update SharedPreferences
      await _saveUserToPrefs(_currentUser!);
      
      notifyListeners();
    } else {
      throw AuthException('Failed to update profile');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> _saveUserToPrefs(User user) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_prefsKey, userJson);
  } catch (e) {
    debugPrint('Error saving user to prefs: $e');
  }
}
```

---

## Integration Points

### 1. Splash Screen

Checks if user is logged in and directs to appropriate screen:

```dart
// lib/screens/onboarding/splash_screen.dart
@override
void initState() {
  super.initState();
  _checkAuthStatus();
}

void _checkAuthStatus() async {
  await Future.delayed(const Duration(seconds: 2));
  
  if (mounted) {
    final authService = context.read<AuthService>();
    final currentUser = authService.getCurrentUser();
    
    if (currentUser != null) {
      // User logged in, go to home
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // No user, go to welcome
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }
}
```

### 2. Main.dart Provider Setup

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: MaterialApp(
        title: 'Nexus Fertility',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/language': (context) => const LanguageSelectionScreen(),
          '/account-type': (context) => const AccountTypeSelectionScreen(),
          '/signup-email': (context) => const EmailSignupScreen(),
          '/signup-phone': (context) => const PhoneSignupScreen(),
          '/profile-setup': (context) => const ProfileSetupScreen(),
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
```

---

## Testing

### Unit Tests

**File**: `test/auth_service_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('signUpWithEmail creates user with valid credentials', () async {
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'TestPassword123',
        firstName: 'John',
        lastName: 'Doe',
        username: 'johndoe',
      );

      expect(user, isNotNull);
      expect(user?.email, 'test@example.com');
      expect(user?.firstName, 'John');
    });

    test('signUpWithEmail throws error with invalid email', () async {
      expect(
        () => authService.signUpWithEmail(
          email: 'invalid-email',
          password: 'TestPassword123',
          firstName: 'John',
          lastName: 'Doe',
          username: 'johndoe',
        ),
        throwsException,
      );
    });

    test('getCurrentUser returns null when no user logged in', () {
      final user = authService.getCurrentUser();
      expect(user, isNull);
    });
  });
}
```

### Widget Tests

**File**: `test/email_signup_screen_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/screens/onboarding/email_signup_screen.dart';
import 'package:nexus_fertility_app/services/auth_service.dart';
import 'package:nexus_fertility_app/services/localization_provider.dart';

void main() {
  group('EmailSignupScreen Widget Tests', () {
    testWidgets('EmailSignupScreen displays all form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()),
            ChangeNotifierProvider(create: (_) => LocalizationProvider()),
          ],
          child: const MaterialApp(home: EmailSignupScreen()),
        ),
      );

      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('EmailSignupScreen shows validation errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()),
            ChangeNotifierProvider(create: (_) => LocalizationProvider()),
          ],
          child: const MaterialApp(home: EmailSignupScreen()),
        ),
      );

      // Try to submit without filling form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpWidget(const SizedBox());

      expect(find.byType(SnackBar), findsWidgets);
    });
  });
}
```

### Integration Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nexus_fertility_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Account Creation Flow Integration Tests', () {
    testWidgets('Complete email signup flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to signup
      await tester.tap(find.text('Create Your Account'));
      await tester.pumpAndSettle();

      // Select language
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      // Select email signup
      await tester.tap(find.byIcon(Icons.email_outlined));
      await tester.pumpAndSettle();

      // Fill form
      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextFormField).at(1), 'john@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'johndoe');
      await tester.enterText(find.byType(TextFormField).at(3), 'Password123');
      await tester.enterText(find.byType(TextFormField).at(4), 'Password123');

      // Accept terms
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // Submit
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Should navigate to profile setup
      expect(find.text('Complete your profile'), findsOneWidget);
    });
  });
}
```

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| OTP not sent | Check SMS service config, verify phone number format |
| Navigation fails | Ensure routes are registered in main.dart |
| Form validation not working | Check TextFormField validators |
| AuthService not updating | Verify notifyListeners() is called |
| Shared preferences empty | Check permissions and init order |

---

## Next Steps

1. **Backend Integration**
   - Connect to actual API endpoints
   - Implement error handling
   - Add logging

2. **Testing**
   - Run unit tests: `flutter test`
   - Run widget tests
   - Perform integration testing

3. **Security**
   - Implement secure storage
   - Add biometric authentication
   - Implement 2FA

4. **Enhancement**
   - Add social login
   - Implement password strength meter
   - Add account recovery options

