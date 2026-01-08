import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_fertility_app/utils/language_utils.dart';

void main() {
  group('Language Restriction Tests', () {
    test('App must support exactly 4 languages', () {
      expect(AppLanguages.supportedLanguageCodes.length, 4);
    });
    
    test('App must support only English, Yoruba, Igbo, Hausa', () {
      expect(AppLanguages.supportedLanguageCodes, contains('en'));
      expect(AppLanguages.supportedLanguageCodes, contains('yo'));
      expect(AppLanguages.supportedLanguageCodes, contains('ig'));
      expect(AppLanguages.supportedLanguageCodes, contains('ha'));
    });
    
    test('App must NOT support Spanish', () {
      expect(AppLanguages.supportedLanguageCodes, isNot(contains('es')));
      expect(AppLanguages.isLanguageSupported('es'), false);
    });
    
    test('App must NOT support French', () {
      expect(AppLanguages.supportedLanguageCodes, isNot(contains('fr')));
      expect(AppLanguages.isLanguageSupported('fr'), false);
    });
    
    test('App must NOT support Portuguese', () {
      expect(AppLanguages.supportedLanguageCodes, isNot(contains('pt')));
      expect(AppLanguages.isLanguageSupported('pt'), false);
    });
    
    test('Invalid language code defaults to English', () {
      expect(AppLanguages.validateLanguageCode('es'), 'en');
      expect(AppLanguages.validateLanguageCode('fr'), 'en');
      expect(AppLanguages.validateLanguageCode('pt'), 'en');
      expect(AppLanguages.validateLanguageCode('invalid'), 'en');
    });
  });
}
