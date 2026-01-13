import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  bool _biometricAvailable = false;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final can = await _localAuth.canCheckBiometrics || await _localAuth.isDeviceSupported();
      setState(() => _biometricAvailable = can);
    } catch (e) {
      setState(() => _biometricAvailable = false);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    setState(() => _isAuthenticating = true);
    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Sign in to Ferti Path',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (didAuthenticate) {
        // Navigate to home
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biometric authentication failed')),
      );
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferti Path Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Ferti Path',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              
              // Email/Password form would go here
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                child: const Text('Continue with Email'),
              ),
              const SizedBox(height: 20),
              
              if (_biometricAvailable)
                ElevatedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: _isAuthenticating 
                    ? const Text('Authenticating...') 
                    : const Text('Sign in with Biometrics'),
                  onPressed: _isAuthenticating ? null : _authenticateWithBiometrics,
                ),
              
              if (!_biometricAvailable)
                const Text('Biometrics not available on this device',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
