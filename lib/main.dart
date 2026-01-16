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

class MyApp extends StatefulWidget {
  final String initialTheme;
  const MyApp({Key? key, required this.initialTheme}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = _stringToThemeMode(widget.initialTheme);
  }

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

  Future<void> _setThemeMode(ThemeMode tm) async {
    setState(() => _themeMode = tm);
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = tm == ThemeMode.system ? 'system' : (tm == ThemeMode.light ? 'light' : 'dark');
      await prefs.setString('theme_mode', key);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, _) {
return MaterialApp(
  title: 'Ferti Path',
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: _themeMode,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: LocalizationProvider.supportedLocales,
  locale: localizationProvider.currentLocale,
  home: const HomeScreen(),
);
        },
      ),
    );
  }
}

