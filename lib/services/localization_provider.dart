import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Immutable list of supported locales
  static final List<Locale> supportedLocales =
      List.unmodifiable(const <Locale>[
    Locale('en'),
    Locale('yo'), // Yoruba
    Locale('ig'), // Igbo
    Locale('ha'), // Hausa
  ]);

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
      notifyListeners();
    }
  }

  void setLocaleByLanguageCode(String languageCode) {
    setLocale(Locale(languageCode));
  }

  // Dummy translate method for build compatibility
  // Returns the key as-is; actual translations should use AppLocalizations
  String translate(String key) {
    return key;
  }
}

