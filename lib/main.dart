import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:nexus_fertility_app/flutter_gen/gen_l10n/app_localizations.dart";
import "services/auth_service.dart";
import "services/localization_provider.dart" as loc_provider;
import "screens/onboarding/language_selection_screen.dart";

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
        ChangeNotifierProvider<AuthServiceImpl>(
          create: (_) => AuthServiceImpl(backendBaseUrl: "https://fertipath-backend.onrender.com"),
        ),
      ],
      child: Consumer<loc_provider.LocalizationProvider>(
        builder: (context, localizationProvider, _) {
          return MaterialApp(
            title: "Nexus Fertility",
            theme: ThemeData(useMaterial3: true),
            locale: localizationProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const LanguageSelectionScreen(),
          );
        },
      ),
    );
  }
}
