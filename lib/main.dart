import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'config/feature_flags.dart';
import 'package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'services/auth_service.dart';

import 'services/localization_provider.dart' as loc_provider;
import 'services/tts_service.dart';

import 'screens/onboarding/language_selection_screen.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'screens/onboarding/login_screen.dart';
import 'screens/onboarding/forget_password_flow.dart';
import 'screens/onboarding/profile_setup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/audio/audio_hub_screen.dart';
import 'screens/support/support_screen.dart';
import 'screens/tracking/cycle_input_screen.dart';
import 'screens/tracking/calendar_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/tracking/sex_timing_screen.dart';
import 'screens/privacy_and_security/privacy_and_security_screen.dart';
import 'screens/community_groups/community_groups_screen.dart';
import 'screens/community_groups/community_group_display_screen.dart';
import 'screens/profile/settings_profile_setup_screen.dart';
import 'screens/prediction/prediction_screen.dart';
import 'screens/educational/educational_hub_screen.dart';
import 'screens/goals/goals_update_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<loc_provider.LocalizationProvider>(
          create: (_) => loc_provider.LocalizationProvider(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
            ChangeNotifierProvider<TtsService>(
          create: (_) => TtsService(),
        ),
      ],
      child: Consumer<loc_provider.LocalizationProvider>(
        builder: (context, localizationProvider, _) {
          return MaterialApp(
            title: 'Nexus Fertility',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            locale: localizationProvider.locale,

            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            home: const SplashScreen(),
            routes: {
              // Core onboarding/navigation
              '/welcome': (context) => const WelcomeScreen(),
              '/login': (context) => const LoginScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/reset-password': (context) => const ResetPasswordScreen(),
              '/password-updated': (context) => const PasswordUpdatedScreen(),
              // New screens:
              PrivacyAndSecurityScreen.routeName: (ctx) => const PrivacyAndSecurityScreen(),
              CommunityGroupsScreen.routeName: (ctx) => const CommunityGroupsScreen(),
              CommunityGroupDisplayScreen.routeName: (ctx) => const CommunityGroupDisplayScreen(),
              SettingsProfileSetupScreen.routeName: (ctx) => const SettingsProfileSetupScreen(),
              '/onboarding/profile': (ctx) => const ProfileSetupScreen(),
              PredictionScreen.routeName: (ctx) => const PredictionScreen(),
              EducationalHubScreen.routeName: (ctx) => const EducationalHubScreen(),
              GoalsUpdateScreen.routeName: (ctx) => const GoalsUpdateScreen(),
              '/home': (context) => const HomeScreen(),
              '/audio': (context) => const AudioHubScreen(),
              '/support': (context) => const SupportScreen(),
              '/calendar': (context) => const CalendarScreen(),
              '/cycle_input': (context) => const CycleInputScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/sex_timing': (context) => const SexTimingPreferencesScreen(),
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}





