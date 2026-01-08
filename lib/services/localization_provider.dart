import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_localizations/flutter_localizations.dart';
>>>>>>> origin/main
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
<<<<<<< HEAD
  Locale get locale => _locale;
  String? _selectedLanguageCode;
  
  String? get selectedLanguageCode => _selectedLanguageCode;

  // Immutable list of supported locales
  static final List<Locale> supportedLocales =
      List.unmodifiable(const <Locale>[
=======

  Locale get locale => _locale;

  static const supportedLocales = [
>>>>>>> origin/main
    Locale('en'),
    Locale('yo'), // Yoruba
    Locale('ig'), // Igbo
    Locale('ha'), // Hausa
<<<<<<< HEAD
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
=======
 ];

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Simple runtime translation map for quick wiring of new screens.
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'yo': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'ig': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'ha': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    }
  };

  String translate(String key) {
    try {
      final code = _locale.languageCode;
      return _localizedValues[code]?[key] ?? _localizedValues['en']?[key] ?? key;
    } catch (e) {
      return key;
    }
  }

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
      // ignore and keep default
    }
  }

  Future<void> _saveToPrefs(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, code);
    } catch (_) {}
  }

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
      notifyListeners();
>>>>>>> origin/main
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

