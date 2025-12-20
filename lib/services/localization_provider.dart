import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  String? _selectedLanguageCode;
  
  String? get selectedLanguageCode => _selectedLanguageCode;

  // Immutable list of supported locales
  static final List<Locale> supportedLocales =
      List.unmodifiable(const <Locale>[
    Locale('en'),
    Locale('yo'), // Yoruba
    Locale('ig'), // Igbo
    Locale('ha'), // Hausa
  ]);

  LocalizationProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString('preferred_language');
      if (savedLanguageCode != null) {
        _selectedLanguageCode = savedLanguageCode;
        _locale = Locale(savedLanguageCode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading saved language: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
      _selectedLanguageCode = locale.languageCode;
      notifyListeners();
      
      // Save to SharedPreferences
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('preferred_language', locale.languageCode);
      } catch (e) {
        debugPrint('Error saving language preference: $e');
      }
    }
  }

  Future<void> setLocaleByLanguageCode(String languageCode) async {
    await setLocale(Locale(languageCode));
  }

  // Dummy translate method for build compatibility
  // Returns the key as-is; actual translations should use AppLocalizations
  String translate(String key) {
    return key;
  }
}

