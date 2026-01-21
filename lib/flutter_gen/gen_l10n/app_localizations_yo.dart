import 'app_localizations.dart';
import 'package:intl/intl.dart' as intl;
// ignore: unused_import

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

  @override
  String get welcomeTitle => 'áº¸ kÃ¡Ã bá»Ì€ sÃ­ Nexus Fertility';

  @override
  String get welcomeSubtitle => 'AlÃ¡bÃ á¹£epá»Ì€ Ã¬bÃ­sÃ­ ráº¹ tÃ­ ara áº¹ni';

  @override
  String get selectLanguage => 'Yan ÃˆdÃ¨';

  @override
  String get english => 'English';

  @override
  String get yoruba => 'YorÃ¹bÃ¡';

  @override
  String get igbo => 'Igbo';

  @override
  String get hausa => 'Hausa';

  @override
  String get pidgin => 'Pidgin';

  @override
  String get german => 'Deutsch';

  @override
  String get next => 'TÃ³kÃ n';

  @override
  String get back => 'PadÃ ';

  @override
  String get skip => 'FÃ²';

  @override
  String get done => 'ParÃ­';

  @override
  String get createAccount => 'á¹¢áº¹Ì€dÃ¡ Ã€ká»á»Ìláº¹Ì€';

  @override
  String get signIn => 'Wá»lÃ©';

  @override
  String get email => 'ÃmeÃ¨lÃ¬';

  @override
  String get phoneNumber => 'Ná»ÌmbÃ  FÃ³Ã²nÃ¹';

  @override
  String get password => 'á»ŒÌ€rá»Ì€Ã¬pamá»Ì';

  @override
  String get confirmPassword => 'Jáº¹ÌrÃ¬Ã­sÃ­ á»ŒÌ€rá»Ì€Ã¬pamá»Ì';

  @override
  String get firstName => 'OrÃºká» Ã€ká»Ìká»Ì';

  @override
  String get lastName => 'OrÃºká» ÃŒdÃ­lÃ©';

  @override
  String get dateOfBirth => 'á»Œjá»Ì ÃŒbÃ­';

  @override
  String get selectDate => 'Yan á»já»';

  @override
  String get profilePicture => 'Ã€wÃ²rÃ¡n Profaili';

  @override
  String get uploadPhoto => 'Gbe Ã€wÃ²rÃ¡n SÃ³kÃ¨';

  @override
  String get takePhoto => 'Ya Ã€wÃ²rÃ¡n';

  @override
  String get chooseFromGallery => 'Yan LÃ¡ti Galáº¹ÌrÃ¬';

  @override
  String get verifyEmail => 'Jáº¹ÌrÃ¬Ã­sÃ­ ÃmeÃ¨lÃ¬';

  @override
  String get verifyPhone => 'Jáº¹ÌrÃ¬Ã­sÃ­ FÃ³Ã²nÃ¹';

  @override
  String get enterOTP => 'Táº¹ OTP';

  @override
  String otpSentTo(String email) {
    return 'A fi OTP rÃ¡ná¹£áº¹Ì sÃ­ $email';
  }

  @override
  String get resendCode => 'TÃºn KÃ³Ã²dÃ¹ RÃ¡ná¹£áº¹Ì';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'KÃ³Ã²dÃ¹ yÃ³Ã² paráº¹Ì nÃ­ $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Já»Ì€wá»Ì táº¹ Ã dÃ­ráº¹Ìáº¹Ì€sÃ¬ Ã­meÃ¨lÃ¬ tÃ³ tá»Ì';

  @override
  String get invalidPhone => 'Já»Ì€wá»Ì táº¹ ná»ÌmbÃ  fÃ³Ã²nÃ¹ tÃ³ tá»Ì';

  @override
  String get passwordMismatch => 'Ã€wá»n á»Ì€rá»Ì€Ã¬pamá»Ì kÃ² bÃ¡ramu';

  @override
  String get passwordTooShort => 'á»ŒÌ€rá»Ì€Ã¬pamá»Ì gbá»dá»Ì€ jáº¹Ì Ã³ kÃ©rÃ© jÃ¹ láº¹ÌtÃ  8';

  @override
  String get accountCreatedSuccessfully => 'A á¹£áº¹Ì€dÃ¡ Ã ká»á»Ìláº¹Ì€ páº¹Ì€lÃº Ã á¹£eyá»rÃ­!';

  @override
  String get profileSetupComplete => 'Ipari profaili ti pari!';

  @override
  String get termsAndConditions => 'Mo gbÃ  Ã wá»n Ã’fin Ã ti ÃŒpÃ²';

  @override
  String get privacyPolicy => 'Mo gbÃ  ÃŒlÃ nÃ  Ã€á¹£Ã­rÃ­';

  @override
  String get acceptTerms => 'Já»Ì€wá»Ì gba Ã wá»n Ã²fin Ã ti Ã¬pÃ²';

  @override
  String get emailAlreadyExists => 'A ti forÃºká»sÃ­láº¹Ì€ Ã­meÃ¨lÃ¬ nÃ¡Ã  táº¹Ìláº¹Ì€';

  @override
  String get phoneAlreadyExists => 'A ti forÃºká»sÃ­láº¹Ì€ ná»ÌmbÃ  fÃ³Ã²nÃ¹ nÃ¡Ã  táº¹Ìláº¹Ì€';

  @override
  String get verificationFailed =>
      'ÃŒjáº¹ÌrÃ¬Ã­sÃ­ kÃ¹nÃ . Já»Ì€wá»Ì gbÃ¬yÃ njÃº láº¹Ìáº¹Ì€kan sÃ­ i';

  @override
  String get tryAgain => 'GbÃ¬yÃ njÃº Láº¹Ìáº¹Ì€kan SÃ­ i';

  @override
  String get loading => 'Åƒ á¹£iá¹£áº¹Ì...';

  @override
  String get error => 'Ã€á¹£Ã¬á¹£e';

  @override
  String get success => 'Ã€á¹£eyá»rÃ­';

  @override
  String get cancel => 'FagÃ­lÃ©';

  @override
  String get save => 'Fipamá»Ì';

  @override
  String get logout => 'JÃ¡de';

  @override
  String get genderMale => 'á»ŒkÃ¹nrin';

  @override
  String get genderFemale => 'ObÃ¬nrin';

  @override
  String get genderOther => 'Ã’mÃ­rÃ n';

  @override
  String get selectGender => 'Yan Aká» tÃ bÃ­ Abo';

  @override
  String get welcomeToJourney => 'áº¸ kÃ¡Ã bá»Ì€ sÃ­ Ã¬rÃ¬nÃ jÃ² ráº¹';

  @override
  String get choosePreferredLanguage => 'Yan Ã¨dÃ¨ tÃ­ o fáº¹Ì jÃ¹';

  @override
  String get choosePreferredMethod => 'Yan á»na tÃ­ o fáº¹Ì jÃ¹';

  @override
  String get createAccountWithEmail => 'á¹¢áº¹Ì€dÃ¡ Ã ká»á»Ìláº¹Ì€ páº¹Ì€lÃº Ã­meÃ¨lÃ¬';

  @override
  String get createAccountWithPhone => 'á¹¢áº¹Ì€dÃ¡ Ã ká»á»Ìláº¹Ì€ páº¹Ì€lÃº fÃ³Ã²nÃ¹';

  @override
  String get emailSignupTitle => 'á¹¢áº¹Ì€dÃ¡ Ã€ká»á»Ìláº¹Ì€ Páº¹Ì€lÃº ÃmeÃ¨lÃ¬';

  @override
  String get emailSignupSubtitle => 'Táº¹ imeeli Ã ti á»Ì€rá»Ì€Ã¬pamá»Ì ráº¹';

  @override
  String get emailAddressLabel => 'Ã€dÃ­ráº¹Ìáº¹Ì€sÃ¬ ÃmeÃ¨lÃ¬';

  @override
  String get emailHint => 'wo@example.com';

  @override
  String get emailRequired => 'ÃmeÃ¨lÃ¬ ni dandan';

  @override
  String get invalidEmailFormat => 'Ã€dÃ­ráº¹Ìáº¹Ì€sÃ¬ Ã­meÃ¨lÃ¬ kÃ² tá»Ì';

  @override
  String get passwordHint => 'Táº¹ á»Ì€rá»Ì€Ã¬pamá»Ì';

  @override
  String get passwordRequired => 'á»ŒÌ€rá»Ì€Ã¬pamá»Ì ni dandan';

  @override
  String get confirmPasswordHint => 'Jáº¹ÌrÃ¬Ã­sÃ­ á»Ì€rá»Ì€Ã¬pamá»Ì';

  @override
  String get confirmPasswordRequired => 'Já»Ì€wá»Ì jáº¹ÌrÃ¬Ã­sÃ­ á»Ì€rá»Ì€Ã¬pamá»Ì';

  @override
  String get phoneSignupTitle => 'á¹¢áº¹Ì€dÃ¡ Ã€ká»á»Ìláº¹Ì€ Páº¹Ì€lÃº FÃ³Ã²nÃ¹';

  @override
  String get phoneSignupSubtitle => 'A Ã³Ã² fi OTP kÃ³Ã²dÃ¹ rÃ¡ná¹£áº¹Ì sÃ­ á»';

  @override
  String get phoneNumberLabel => 'Ná»ÌmbÃ  FÃ³Ã²nÃ¹';

  @override
  String get phoneNumberHint => 'Ná»ÌmbÃ  fÃ³Ã²nÃ¹';

  @override
  String get phoneRequired => 'FÃ³Ã²nÃ¹ ni dandan';

  @override
  String get invalidPhoneForCountry => 'Ná»ÌmbÃ  fÃ³Ã²nÃ¹ kÃ² tá»Ì fÃºn orÃ­láº¹Ì€-Ã¨dÃ¨ yÃ¬Ã­';

  @override
  String get otpInfoMessage =>
      'A Ã³Ã² fi OTP kÃ³Ã²dÃ¹ rÃ¡ná¹£áº¹Ì lÃ¡ti jáº¹ÌrÃ¬Ã­sÃ­ ná»ÌmbÃ  fÃ³Ã²nÃ¹ ráº¹';

  @override
  String get continueText => 'Táº¹Ì€sÃ­wÃ¡jÃº';

  @override
  String get verifyEmailTitle => 'Jáº¹ÌrÃ¬Ã­sÃ­ ÃmeÃ¨lÃ¬';

  @override
  String get verifyPhoneTitle => 'Jáº¹ÌrÃ¬Ã­sÃ­ Ná»ÌmbÃ  FÃ³Ã²nÃ¹';

  @override
  String codeSentToEmail(String email) {
    return 'Táº¹ kÃ³Ã²dÃ¹ tÃ­ a fi rÃ¡ná¹£áº¹Ì sÃ­ $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Táº¹ kÃ³Ã²dÃ¹ tÃ­ a fi rÃ¡ná¹£áº¹Ì sÃ­ $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'KÃ³Ã²dÃ¹ yÃ³Ã² paráº¹Ì nÃ­ $time';
  }

  @override
  String get verify => 'Jáº¹ÌrÃ¬Ã­sÃ­';

  @override
  String get didntReceiveCode => 'Ko gbÃ  kÃ³Ã²dÃ¹? TÃºn rÃ¡ná¹£áº¹Ì';

  @override
  String get enterAll6Digits => 'Já»Ì€wá»Ì táº¹ gbogbo ná»ÌmbÃ  6';

  @override
  String get profile => 'Profaili';

  @override
  String get completeProfile => 'Jáº¹ ki a pari profaili ráº¹';

  @override
  String get personalizeGuide =>
      'Eyi yoo ran wa lá»wá» lati á¹£e itá»sá»na ayipo ráº¹ ni ara áº¹ni';

  @override
  String get age => 'á»Œjá» ori';

  @override
  String get cycleLength => 'Gigun ayipo';

  @override
  String days(Object count) {
    return 'á»Œjá» $count';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Ná»mba aropin ti awá»n á»já» laarin awá»n akoko oá¹£u ráº¹';

  @override
  String get lastPeriodDate => 'á»Œjá» akoko oá¹£u to káº¹hin';

  @override
  String get whenLastBleeding => 'Nigbati eje oá¹£u ráº¹ to káº¹hin báº¹ráº¹';

  @override
  String get ttcHistory => 'Itan TTC';

  @override
  String get faithPreference => 'Yiyan igbagbá»';

  @override
  String get language => 'Ede';

  @override
  String get audioGuidance => 'Itá»sá»na ohun';

  @override
  String get agreeTerms => 'Mo gba awá»n ofin ati Ilana Asiri';

  @override
  String get selectOption => 'Yan aá¹£ayan';

  @override
  String get home => 'Ile';

  @override
  String get calendar => 'Kaláº¹nda';

  @override
  String get learn => 'Ká» áº¹ká»';

  @override
  String get todaysFertilityInsight => 'Imá»ran á»má»binrin ti oni';

  @override
  String get nextFertilityWindow => 'Ferese á»má»binrin ráº¹ ti n bá» lati Dec 23';

  @override
  String get trackingBenefits =>
      'Nipa titá»pa á»má»binrin ráº¹ o ni oye ti o dara julá» nipa ayipo ráº¹.';

  @override
  String get stayPositive => 'O n á¹£e daradara! Duro ni idayatá» ki o si dojuká»!';

  @override
  String get learnHub => 'Ile-ikawe';

  @override
  String get logSymptoms => 'Foruká»siláº¹ awá»n ami aisan';

  @override
  String get bleeding => 'Eje';

  @override
  String get mood => 'IÈ™esi á»kan';

  @override
  String get cervicalMucus => 'Omi á»run';

  @override
  String get pain => 'Irora';

  @override
  String get notes => 'Awá»n aká»siláº¹';

  @override
  String get loggedSymptoms => 'Awá»n ami aisan ti a foruká»siláº¹';

  @override
  String get educationalContentComingSoon => 'Akoonu áº¹ká» n bá» laipáº¹';

  @override
  String get authInvalidEmail => 'á»Œna email ko tá»';

  @override
  String get authInvalidPhone => 'Ná»mba foonu ko tá»';

  @override
  String get authPasswordTooShort =>
      'á»Œrá» igbaniwá»le gbá»dá» jáº¹ o kere ju awá»n láº¹ta 8';

  @override
  String get authEmailAlreadyRegistered => 'A ti foruká»siláº¹ email yii táº¹láº¹';

  @override
  String get authPhoneAlreadyRegistered =>
      'A ti foruká»siláº¹ ná»mba foonu yii táº¹láº¹';

  @override
  String get authInvalidOtpFormat => 'á»Œna OTP ko tá»';

  @override
  String get authUserNotFound => 'A ko rii olumulo';

  @override
  String get authNoUserLoggedIn => 'Ko si olumulo ti o wá»le';

  @override
  String get welcomeBack => 'Kabo pada';

  @override
  String get logInToAccount => 'Wá»le si akaunt ráº¹';

  @override
  String get emailAddress => 'Adiresi email';

  @override
  String get emailHintLogin => 'iwo@apere.com';

  @override
  String get passwordLabel => 'á»Œrá» igbaniwá»le';

  @override
  String get enterPassword => 'Táº¹ á»ro igbaniwá»le sii';

  @override
  String get forgotPassword => 'á¹¢e o gbÃ gbÃ© á»ro igbaniwá»le?';

  @override
  String get logIn => 'Wá»le';
}



