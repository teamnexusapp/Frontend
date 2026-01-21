import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:nexus_fertility_app/services/localization_provider.dart';
import 'package:nexus_fertility_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Nexus Fertility',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system, // Use system theme
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeProvider.locale,
            home: Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.appTitle),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 100,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.appTitle,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 30),
                    Consumer<LocalizationProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            Text(
                              'Current Language: ${provider.selectedLanguageCode}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => provider.setLocaleByLanguageCode('en'),
                                  child: Text('English'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () => provider.setLocaleByLanguageCode('pt'),
                                  child: Text('Português'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () => provider.setLocaleByLanguageCode('yo'),
                                  child: Text('Yorùbá'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      'App Icon and Splash Screen fixed',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dark Mode colors configured',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Localization working for 3 languages',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
