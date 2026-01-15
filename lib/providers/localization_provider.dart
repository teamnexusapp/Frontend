import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ha'),
    Locale('pcm'),
    Locale('yo'),
    Locale('ig'),
  ];

  final SharedPreferences _prefs;
  late Locale _locale;

  LocalizationProvider(this._prefs) {
    _loadLocale();
  }

  Locale get locale => _locale;

  void _loadLocale() {
    final saved = _prefs.getString(_localeKey) ?? 'en';
    _locale = Locale(saved);
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    _locale = locale;
    await _prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  String get currentLanguageName {
    switch (_locale.languageCode) {
      case 'en':
        return 'English';
      case 'ha':
        return 'Hausa';
      case 'pcm':
        return 'Pidgin';
      case 'yo':
        return 'Yoruba';
      case 'ig':
        return 'Igbo';
      default:
        return 'English';
    }
  }
}
