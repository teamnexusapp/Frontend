// Language utilities - ONLY 4 LANGUAGES ALLOWED
// This file enforces the language restriction policy

class AppLanguages {
  static const List<String> supportedLanguageCodes = ['en', 'yo', 'ig', 'ha'];
  
  static const Map<String, String> languageNames = {
    'en': 'English',
    'yo': 'Yoruba',
    'ig': 'Igbo',
    'ha': 'Hausa',
  };
  
  // NEVER add more languages here
  // The app must ONLY support these 4 languages
  static List<Map<String, String>> get languageOptions => [
    {'code': 'en', 'name': 'English'},
    {'code': 'yo', 'name': 'Yoruba'},
    {'code': 'ig', 'name': 'Igbo'},
    {'code': 'ha', 'name': 'Hausa'},
  ];
  
  static bool isLanguageSupported(String languageCode) {
    return supportedLanguageCodes.contains(languageCode);
  }
  
  // CRITICAL: This function prevents any unauthorized language from being set
  static String validateLanguageCode(String code) {
    return isLanguageSupported(code) ? code : 'en';
  }
}
