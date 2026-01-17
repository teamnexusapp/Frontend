import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import '../screens/onboarding/login_screen.dart' as OnboardingLogin;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Delegate to the main onboarding login implementation
    return const OnboardingLogin.LoginScreen();
  }
}
                  onPressed: _isAuthenticating ? null : _authenticateWithBiometrics,
                ),
              
              if (!_biometricAvailable)
                Text(
                  'Biometrics not available on this device',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
