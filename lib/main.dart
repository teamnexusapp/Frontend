import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/feature_flags.dart';
import 'firebase_options.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'services/auth_service.dart';
<<<<<<< HEAD
import 'services/localization_provider.dart';
import 'services/tts_service.dart';
=======

import 'services/localization_provider.dart' as loc_provider;
>>>>>>> origin/main
import 'screens/onboarding/language_selection_screen.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/home_screen.dart';
<<<<<<< HEAD
import 'screens/audio/audio_hub_screen.dart';
import 'screens/support/support_screen.dart';
import 'screens/community_groups/community_groups_screen.dart';
import 'screens/tracking/calendar_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/tracking/sex_timing_screen.dart';
import 'theme.dart';
import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  try {
    if (FeatureFlags.firebaseAuthAvailable) {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } else {
        await Firebase.initializeApp();
      }
    }
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization error: ');
    debugPrint('Firebase auth disabled; using backend-only auth flows');
  }

  // Theme init
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('theme_mode') ?? 'system';

  runApp(MyApp(initialTheme: saved));
=======

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
>>>>>>> origin/main
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
    final prefs = await SharedPreferences.getInstance();
    setState(() => _themeMode = tm);
    final key = tm == ThemeMode.system
        ? 'system'
        : (tm == ThemeMode.light ? 'light' : 'dark');
    await prefs.setString('theme_mode', key);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
<<<<<<< HEAD
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => TTSService()),
=======
        ChangeNotifierProvider<loc_provider.LocalizationProvider>(
          create: (_) => loc_provider.LocalizationProvider(),
        ),
        ChangeNotifierProvider<AuthServiceImpl>(
          create: (_) => AuthServiceImpl(),
        ),
>>>>>>> origin/main
      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, _) {
          return MaterialApp(
            title: 'Ferti Path',
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: _themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...loc_provider.LocalizationProvider.localizationsDelegates,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ha', ''),
              Locale('ig', ''),
              Locale('yo', ''),
            ],
            locale: localizationProvider.currentLocale,
            home: const LoginScreen()(),
            routes: {
              '/home': (context) => const HomeScreen(),
<<<<<<< HEAD
              '/audio': (context) => const AudioHubScreen(),
              '/support': (context) => const SupportScreen(),
              '/community': (context) => const CommunityGroupsScreen(),
              '/calendar': (context) => const CalendarScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/sex-timing': (context) => const SexTimingScreen(),
=======
>>>>>>> origin/main
            },
          );
        },
      ),
    );
  }
}
