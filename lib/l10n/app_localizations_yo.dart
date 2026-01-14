// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

  @override
  String get welcomeTitle => 'Ẹ káàbọ̀ sí Nexus Fertility';

  @override
  String get welcomeSubtitle => 'Alágbátà ìmú-ọmọ ara ẹni';

  @override
  String get selectLanguage => 'Yan Ede';

  @override
  String get english => 'English';

  @override
  String get yoruba => 'Yoruba';

  @override
  String get igbo => 'Igbo';

  @override
  String get hausa => 'Hausa';

  @override
  String get pidgin => 'Pidgin';

  @override
  String get german => 'Deutsch';

  @override
  String get next => 'Tẹ̀síwájú';

  @override
  String get back => 'Padà Síwájú';

  @override
  String get skip => 'Kọjá';

  @override
  String get done => 'Tán';

  @override
  String get createAccount => 'Ṣẹ̀dá Àkàǹtì';

  @override
  String get signIn => 'Wọlé';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Nọ́ńbà Fóònù';

  @override
  String get password => 'Ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get confirmPassword => 'Jẹ́rìsí Ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get firstName => 'Orúkọ Ìbẹ̀rẹ̀';

  @override
  String get lastName => 'Orúkọ Ìdílé';

  @override
  String get dateOfBirth => 'Ọjọ́ Ìbí';

  @override
  String get selectDate => 'Yan ọjọ́';

  @override
  String get profilePicture => 'Àwòrán Profáìlì';

  @override
  String get uploadPhoto => 'Gbé Àwòrán Sókè';

  @override
  String get takePhoto => 'Yà Àwòrán';

  @override
  String get chooseFromGallery => 'Yan Látinú Gálárì';

  @override
  String get verifyEmail => 'Jẹ́rìsí Email';

  @override
  String get verifyPhone => 'Jẹ́rìsí Nọ́ńbà Fóònù';

  @override
  String get enterOTP => 'Tẹ OTP';

  @override
  String otpSentTo(String email) {
    return 'OTP ránṣẹ́ sí $email';
  }

  @override
  String get resendCode => 'Tún Kóòdù Ránṣẹ́';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Kóòdù yóò parẹ̀ ní $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Jọ̀wọ́ tẹ àdírẹ́sì ẹ̀mèèlì tó tọ́';

  @override
  String get invalidPhone => 'Jọ̀wọ́ tẹ nọ́ńbà fóònù tó tọ́';

  @override
  String get passwordMismatch => 'Àwọn Ọ̀rọ̀ ìgbaniwọ́le kò báramu';

  @override
  String get passwordTooShort => 'Ọ̀rọ̀ ìgbaniwọ́le gbọdọ jẹ́ ó kéré jù látà 8';

  @override
  String get accountCreatedSuccessfully => 'A ṣẹ̀dá àkàǹtì pẹ̀lú ẹ̀ṣẹ́!';

  @override
  String get profileSetupComplete => 'Ipari profáìlì ti pari!';

  @override
  String get termsAndConditions => 'Mo gba àwọn Òfin àti Ìpò';

  @override
  String get privacyPolicy => 'Mo gba Ìlànà Àṣírí';

  @override
  String get acceptTerms => 'Jọ̀wọ́ gba àwọn òfin àti ìpò';

  @override
  String get emailAlreadyExists => 'A ti forúkọsílẹ̀ ẹ̀mèèlì náà tẹ́lẹ̀';

  @override
  String get phoneAlreadyExists => 'A ti forúkọsílẹ̀ nọ́ńbà fóònù náà tẹ́lẹ̀';

  @override
  String get verificationFailed =>
      'Ìjẹ́rìsí kùnà. Jọ̀wọ́ gbìyànjú lẹ́ẹ̀kan sí i';

  @override
  String get tryAgain => 'Gbìyànjú Lẹ́ẹ̀kan Sí i';

  @override
  String get loading => 'Ǹ ṣiṣẹ́...';

  @override
  String get error => 'Àṣìṣe';

  @override
  String get success => 'Àṣeyọrí';

  @override
  String get cancel => 'Fagilé';

  @override
  String get save => 'Fipamọ́';

  @override
  String get logout => 'Jáde';

  @override
  String get genderMale => 'Ọkùnrin';

  @override
  String get genderFemale => 'Obìnrin';

  @override
  String get genderOther => 'Ọmọ ẹgbẹ́';

  @override
  String get selectGender => 'Yan Akọ tàbí Abo';

  @override
  String get welcomeToJourney => 'Ẹ káàbọ̀ sí ìrìnàjò rẹ';

  @override
  String get choosePreferredLanguage => 'Yan èdè tí o fẹ́ jù';

  @override
  String get choosePreferredMethod => 'Yan ọna tí o fẹ́ jù';

  @override
  String get createAccountWithEmail => 'Ṣẹ̀dá Àkàǹtì Nípa Ẹ̀mèèlì';

  @override
  String get createAccountWithPhone => 'Ṣẹ̀dá Àkàǹtì Nípa Fóònù';

  @override
  String get emailSignupTitle => 'Ṣẹ̀dá Àkàǹtì Nípa Ẹ̀mèèlì';

  @override
  String get emailSignupSubtitle => 'Tẹ ẹ̀mèèlì àti ọ̀rọ̀ ìgbaniwọ́le rẹ';

  @override
  String get emailAddressLabel => 'Àdírẹ́sì Ẹ̀mèèlì';

  @override
  String get emailHint => 'wọ@àpẹrẹ.com';

  @override
  String get emailRequired => 'Ẹ̀mèèlì ni dandan';

  @override
  String get invalidEmailFormat => 'Àdírẹ́sì ẹ̀mèèlì kò tọ́';

  @override
  String get passwordHint => 'Tẹ ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get passwordRequired => 'Ọ̀rọ̀ ìgbaniwọ́le ni dandan';

  @override
  String get confirmPasswordHint => 'Jẹ́rìsí ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get confirmPasswordRequired => 'Jọ̀wọ́ jẹ́rìsí ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get phoneSignupTitle => 'Ṣẹ̀dá Àkàǹtì Nípa Fóònù';

  @override
  String get phoneSignupSubtitle => 'A óò fi OTP kóòdù ránṣẹ́ sí ọ';

  @override
  String get phoneNumberLabel => 'Nọ́ńbà Fóònù';

  @override
  String get phoneNumberHint => 'Nọ́ńbà fóònù';

  @override
  String get phoneRequired => 'Fóònù ni dandan';

  @override
  String get invalidPhoneForCountry => 'Nọ́ńbà fóònù kò tọ́ fún orílẹ̀-èdè yìí';

  @override
  String get otpInfoMessage =>
      'A óò fi OTP kóòdù ránṣẹ́ látí jẹ́rìsí nọ́ńbà fóònù rẹ';

  @override
  String get continueText => 'Tẹ̀síwájú';

  @override
  String get verifyEmailTitle => 'Jẹ́rìsí Ẹ̀mèèlì';

  @override
  String get verifyPhoneTitle => 'Jẹ́rìsí Nọ́ńbà Fóònù';

  @override
  String codeSentToEmail(String email) {
    return 'Tẹ kóòdù tí a fi ránṣẹ́ sí $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Tẹ kóòdù tí a fi ránṣẹ́ sí $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Kóòdù yóò parẹ̀ ní $time';
  }

  @override
  String get verify => 'Jẹ́rìsí';

  @override
  String get didntReceiveCode => 'Kò gbà kóòdù? Tún ránṣẹ́';

  @override
  String get enterAll6Digits => 'Jọ̀wọ́ tẹ gbogbo nọ́ńbà 6';

  @override
  String get profile => 'Profáìlì';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get completeProfile => 'Jẹ́ kí a pari profáìlì rẹ';

  @override
  String get personalizeGuide =>
      'Eyi yoo ran wa lọ́wọ́ láti ṣe ìtọ́sọ́na ayipo rẹ ni ara ẹni';

  @override
  String get age => 'Ọjọ ori';

  @override
  String get cycleLength => 'Gígùn ayipo';

  @override
  String days(Object count) {
    return 'Ọjọ́ $count';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Nọ́ńbà àròpín ti àwọn ọjọ́ laarin àwọn akoko oṣù rẹ';

  @override
  String get lastPeriodDate => 'Ọjọ́ akoko oṣù tó kẹ́hìn';

  @override
  String get whenLastBleeding => 'Nígbàtí ẹjẹ oṣù rẹ tó kẹ́hìn bẹ̀rẹ̀';

  @override
  String get ttcHistory => 'Ìtàn TTC';

  @override
  String get faithPreference => 'Yíyàn ìgbàgbọ́';

  @override
  String get language => 'Ede';

  @override
  String get audioGuidance => 'Ìtọ́sọ́na ohùn';

  @override
  String get agreeTerms => 'Mo gba àwọn ofin ati Ilana Asiri';

  @override
  String get selectOption => 'Yan aṣayan';

  @override
  String get home => 'Ilé';

  @override
  String get calendar => 'Kalẹ́ndà';

  @override
  String get learn => 'Kọ́ ẹkọ́';

  @override
  String get todaysFertilityInsight => 'Ìmọ̀ran ọmúbìnrin ti oni';

  @override
  String get nextFertilityWindow => 'Fẹ́rèsè ọmúbìnrin rẹ tí n bọ̀ láti Dec 23';

  @override
  String get trackingBenefits =>
      'Nípa títọpa ọmúbìnrin rẹ o ní oye tí o dara jùlọ nípa ayipo rẹ.';

  @override
  String get stayPositive =>
      'O n ṣe daradara! Dúró ní ìdáyàtọ̀ kí o sì dojúkọ̀!';

  @override
  String get learnHub => 'Ilé-ìkàwé';

  @override
  String get logSymptoms => 'Forúkọsílẹ̀ àwọn àmì àìsàn';

  @override
  String get bleeding => 'Ẹjẹ';

  @override
  String get mood => 'Ìhùwàsí ọkàn';

  @override
  String get cervicalMucus => 'Omi ọrun';

  @override
  String get pain => 'Ìrora';

  @override
  String get notes => 'Àwọn akọsílẹ̀';

  @override
  String get loggedSymptoms => 'Àwọn àmì àìsàn tí a forúkọsílẹ̀';

  @override
  String get educationalContentComingSoon => 'Akoonu ẹkọ n bọ̀ láipẹ́';

  @override
  String get authInvalidEmail => 'Ọna email kò tọ́';

  @override
  String get authInvalidPhone => 'Nọ́ńbà fóònù kò tọ́';

  @override
  String get authPasswordTooShort =>
      'Ọ̀rọ̀ ìgbaniwọ́le gbọdọ jẹ́ o kéré jù àwọn látà 8';

  @override
  String get authEmailAlreadyRegistered =>
      'A ti forúkọsílẹ̀ ẹ̀mèèlì yìí tẹ́lẹ̀';

  @override
  String get authPhoneAlreadyRegistered =>
      'A ti forúkọsílẹ̀ nọ́ńbà fóònù yìí tẹ́lẹ̀';

  @override
  String get authInvalidOtpFormat => 'Ọna OTP kò tọ́';

  @override
  String get authUserNotFound => 'A kò ríi olùmúlò';

  @override
  String get authNoUserLoggedIn => 'Kò sí olùmúlò tí o wọlé';

  @override
  String get welcomeBack => 'Káàbọ̀ padà';

  @override
  String get logInToAccount => 'Wọlé sí àkàǹtì rẹ';

  @override
  String get emailAddress => 'Adirẹsi email';

  @override
  String get emailHintLogin => 'ìwọ@àpẹrẹ.com';

  @override
  String get passwordLabel => 'Ọ̀rọ̀ ìgbaniwọ́le';

  @override
  String get enterPassword => 'Tẹ ọ̀rọ̀ ìgbaniwọ́le sí i';

  @override
  String get forgotPassword => 'Ṣé o gbàgbé ọ̀rọ̀ ìgbaniwọ́le?';

  @override
  String get logIn => 'Wọlé';
}
