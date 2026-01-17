import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'services/auth_service.dart';
import 'services/localization_provider.dart';
import 'screens/home_screen.dart';
import 'theme.dart';
import 'services/theme_provider.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'screens/onboarding/login_screen.dart' as OnboardingLogin;
import 'screens/onboarding/language_selection_screen.dart';
import 'screens/onboarding/forget_password_flow.dart';

Future<void> _initializeFirebase() async {
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyC1VNI1fON-XfBvFszUTt0oZwHtsgaqcYs",
          authDomain: "fertility-app-backend-5578a.firebaseapp.com",
          projectId: "fertility-app-backend-5578a",
          storageBucket: "fertility-app-backend-5578a.firebasestorage.app",
          messagingSenderId: "293422244200",
          appId: "1:293422244200:web:your-web-app-id",
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint('Firebase initialization timeout on web');
          throw Exception('Firebase initialization timeout');
        },
      );
    } else {
      await Firebase.initializeApp();
    }
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
    debugPrint('App will continue without Firebase - using fallback authentication');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await _initializeFirebase();

  String saved = 'system';
  try {
    final prefs = await SharedPreferences.getInstance();
    saved = prefs.getString('theme_mode') ?? 'system';
  } catch (e) {
    debugPrint('SharedPreferences initialization error: $e');
    debugPrint('Using default theme: system');
  }

  runApp(MyApp(initialTheme: saved));
}

class MyApp extends StatelessWidget {
  final String initialTheme;
  const MyApp({Key? key, required this.initialTheme}) : super(key: key);

  ThemeMode _stringToThemeMode(String s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(initialMode: _stringToThemeMode(initialTheme))),
      ],
      child: Consumer2<LocalizationProvider, ThemeProvider>(
        builder: (context, localizationProvider, themeProvider, _) {
          return MaterialApp(
            title: 'Ferti Path',
            theme: appTheme,
            darkTheme: appDarkTheme,
            themeMode: themeProvider.mode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocalizationProvider.supportedLocales,
            locale: localizationProvider.currentLocale,
            onGenerateRoute: (settings) {
              final name = settings.name ?? '';
              Uri uri;
              try {
                uri = Uri.parse(name);
              } catch (_) {
                uri = Uri(path: name);
              }
              switch (uri.path) {
                case '/welcome':
                  return MaterialPageRoute(builder: (_) => const WelcomeScreen());
                case '/login':
                  return MaterialPageRoute(builder: (_) => const OnboardingLogin.LoginScreen());
                case '/reset_password':
                  return MaterialPageRoute(builder: (_) => ResetPasswordScreen(token: uri.queryParameters['token']));
                case '/password-updated':
                  return MaterialPageRoute(builder: (_) => const PasswordUpdatedScreen());
                case '/language':
                  return MaterialPageRoute(builder: (_) => const LanguageSelectionScreen());
                case '/forgot-password':
                  return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
                default:
                  return MaterialPageRoute(builder: (_) => const HomeScreen());
              }
            },
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

