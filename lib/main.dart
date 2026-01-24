import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "screens/onboarding/splash_screen.dart";
import "screens/onboarding/welcome_screen.dart";
import "screens/onboarding/login_screen.dart";
import "screens/onboarding/registration_screen.dart";
import "screens/onboarding/forget_password_flow.dart" 
    show ForgotPasswordScreen, ResetPasswordScreen, PasswordUpdatedScreen;
import "screens/home_screen.dart";
import "services/auth_service.dart";
import "theme/app_theme.dart";

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
      ],
      child: MaterialApp(
        title: "Nexus Fertility",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/reset-password': (context) => const ResetPasswordScreen(),
          '/password-updated': (context) => const PasswordUpdatedScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
