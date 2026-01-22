import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _prefsKey = 'preferred_language';

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('pt'),
    Locale('yo'),
  ];

  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  String? get selectedLanguageCode => _locale.languageCode;

  LocalizationProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey);
      if (code != null && code.isNotEmpty) {
        final locale = Locale(code);
        if (supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
          _locale = locale;
          notifyListeners();
        }
      }
    } catch (_) {
      // Ignore errors
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
      _locale = locale;
      notifyListeners();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_prefsKey, locale.languageCode);
      } catch (_) {}
    }
  }

  Future<void> setLocaleByLanguageCode(String code) async {
    await setLocale(Locale(code));
  }

  static AppLocalizations? of(BuildContext context) {
    return AppLocalizations.of(context);
  }

  // Helper method to get translated text
  static String translate(BuildContext context, String Function(AppLocalizations) translation) {
    final localizations = AppLocalizations.of(context);
    if (localizations != null) {
      return translation(localizations);
    }
    return '';
  }
}
