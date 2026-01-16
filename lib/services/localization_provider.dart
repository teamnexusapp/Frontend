import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _prefsKey = 'preferred_language';

  // Add Pidgin 'pcm' locale here as supported
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ha'),
    Locale('ig'),
    Locale('yo'),
    Locale('pcm'),
  ];

  Locale _locale = const Locale('en');
  Locale get currentLocale => _locale;
  // Backwards-compatible getters used across the app
  Locale get locale => _locale;
  String? get selectedLanguageCode => _locale.languageCode;

  final Map<String, Map<String, String>> _translations = {};

  LocalizationProvider() {
    _loadFromPrefs();
    _loadArbTranslations();
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
    } catch (_) {}
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

  /// Convenience: set locale by language code (e.g. 'en','ha','pcm')
  Future<void> setLocaleByLanguageCode(String code) async {
    final locale = Locale(code);
    await setLocale(locale);
  }

  // Load ARB files from the package to provide a simple translate(key) API
  Future<void> _loadArbTranslations() async {
    for (final locale in supportedLocales) {
      final code = locale.languageCode;
      try {
        final content = await rootBundle.loadString('lib/l10n/app_$code.arb');
        final Map<String, dynamic> jsonMap = json.decode(content) as Map<String, dynamic>;
        final Map<String, String> flat = {};
        jsonMap.forEach((k, v) {
          if (v is String) flat[k] = v;
        });
        _translations[code] = flat;
      } catch (e) {
        // ignore missing or parse errors; translation will fallback to key
      }
    }
    notifyListeners();
  }

  String translate(String key) {
    final code = _locale.languageCode;
    return _translations[code]?[key] ?? key;
  }
}

