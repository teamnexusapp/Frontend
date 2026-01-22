import 'app_localizations.dart';
import 'package:intl/intl.dart' as intl;
// ignore: unused_import

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

  @override
  String get welcomeTitle => 'Barka da zuwa Nexus Fertility';

  @override
  String get welcomeSubtitle => 'Mataimaki na haihuwa na sirri';

  @override
  String get selectLanguage => 'ZaÉ“i Harshe';

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
  String get next => 'Na gaba';

  @override
  String get back => 'Koma baya';

  @override
  String get skip => 'Tsallake';

  @override
  String get done => 'An gama';

  @override
  String get createAccount => 'Æ˜irÆ™iri Asusun';

  @override
  String get signIn => 'Shiga';

  @override
  String get email => 'Imel';

  @override
  String get phoneNumber => 'Lambar Waya';

  @override
  String get password => 'Kalmar Sirri';

  @override
  String get confirmPassword => 'Tabbatar da Kalmar Sirri';

  @override
  String get firstName => 'Sunan Farko';

  @override
  String get lastName => 'Sunan Iyali';

  @override
  String get dateOfBirth => 'Ranar Haihuwa';

  @override
  String get selectDate => 'ZaÉ“i ranar';

  @override
  String get profilePicture => 'Hoton Bayanan Martaba';

  @override
  String get uploadPhoto => 'Loda Hoto';

  @override
  String get takePhoto => 'ÆŠauki Hoto';

  @override
  String get chooseFromGallery => 'ZaÉ“a Daga Gallery';

  @override
  String get verifyEmail => 'Tabbatar da Imel';

  @override
  String get verifyPhone => 'Tabbatar da Waya';

  @override
  String get enterOTP => 'Shigar da OTP';

  @override
  String otpSentTo(String email) {
    return 'An aika OTP zuwa $email';
  }

  @override
  String get resendCode => 'Sake Aika Lambar';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Lambar za ta Æ™are a $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Don Allah shigar da ingantaccen adireshin imel';

  @override
  String get invalidPhone => 'Don Allah shigar da ingantaccen lambar waya';

  @override
  String get passwordMismatch => 'Kalmomin sirri ba su dace ba';

  @override
  String get passwordTooShort =>
      'Kalmar sirri dole ta kasance aÆ™alla haruffa 8';

  @override
  String get accountCreatedSuccessfully => 'An Æ™irÆ™iri asusun nasara!';

  @override
  String get profileSetupComplete => 'An kammala saita bayanan!';

  @override
  String get termsAndConditions => 'Na yarda da SharuÉ—É—a da Yanayi';

  @override
  String get privacyPolicy => 'Na yarda da Manufar Sirri';

  @override
  String get acceptTerms => 'Don Allah karÉ“i sharuÉ—É—a da yanayi';

  @override
  String get emailAlreadyExists => 'An riga an yi rajistar imel';

  @override
  String get phoneAlreadyExists => 'An riga an yi rajistar lambar waya';

  @override
  String get verificationFailed => 'Tabbatarwa ta gaza. Don Allah sake gwadawa';

  @override
  String get tryAgain => 'Sake Gwadawa';

  @override
  String get loading => 'Ana ÆŠorawa...';

  @override
  String get error => 'Kuskure';

  @override
  String get success => 'Nasara';

  @override
  String get cancel => 'Soke';

  @override
  String get save => 'Ajiye';

  @override
  String get logout => 'Fita';

  @override
  String get genderMale => 'Namiji';

  @override
  String get genderFemale => 'Mace';

  @override
  String get genderOther => 'Wani';

  @override
  String get selectGender => 'ZaÉ“i Jinsi';

  @override
  String get welcomeToJourney => 'Barka da zuwa tafiyarku';

  @override
  String get choosePreferredLanguage => 'ZaÉ“i harshen da kake so';

  @override
  String get choosePreferredMethod => 'ZaÉ“i hanyar da kake so';

  @override
  String get createAccountWithEmail => 'Æ˜irÆ™iri asusu da imel';

  @override
  String get createAccountWithPhone => 'Æ˜irÆ™iri asusu da waya';

  @override
  String get emailSignupTitle => 'Æ˜irÆ™iri Asusu da Imel';

  @override
  String get emailSignupSubtitle => 'Shigar da imel da kalmar sirri';

  @override
  String get emailAddressLabel => 'Adireshin Imel';

  @override
  String get emailHint => 'kai@example.com';

  @override
  String get emailRequired => 'Imel dole ne';

  @override
  String get invalidEmailFormat => 'Tsarin imel bai dace ba';

  @override
  String get passwordHint => 'Shigar da kalmar sirri';

  @override
  String get passwordRequired => 'Kalmar sirri dole ne';

  @override
  String get confirmPasswordHint => 'Tabbatar da kalmar sirri';

  @override
  String get confirmPasswordRequired => 'Don Allah tabbatar da kalmar sirri';

  @override
  String get phoneSignupTitle => 'Æ˜irÆ™iri Asusu da Waya';

  @override
  String get phoneSignupSubtitle => 'Za mu aika muku OTP lambar';

  @override
  String get phoneNumberLabel => 'Lambar Waya';

  @override
  String get phoneNumberHint => 'Lambar waya';

  @override
  String get phoneRequired => 'Waya dole ne';

  @override
  String get invalidPhoneForCountry => 'Lambar waya bai dace ba ga wannan Æ™asa';

  @override
  String get otpInfoMessage =>
      'Za mu aiko muku da OTP lambar don tabbatar da lambar wayar ku';

  @override
  String get continueText => 'Ci gaba';

  @override
  String get verifyEmailTitle => 'Tabbatar da Imel';

  @override
  String get verifyPhoneTitle => 'Tabbatar da Lambar Waya';

  @override
  String codeSentToEmail(String email) {
    return 'Shigar da lambar da muka aiko $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Shigar da lambar da muka aiko $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Lambar za ta Æ™are a $time';
  }

  @override
  String get verify => 'Tabbatar';

  @override
  String get didntReceiveCode => 'Ba ka samu lambar ba? Sake aika';

  @override
  String get enterAll6Digits => 'Don Allah shigar da dukkan lambobi 6';

  @override
  String get profile => 'Bayani';

  @override
  String get completeProfile => 'Bari mu kammala bayanan ku';

  @override
  String get personalizeGuide =>
      'Wannan zai taimaka mana mu keÉ“anta jagorar zagayowar ku';

  @override
  String get age => 'Shekaru';

  @override
  String get cycleLength => 'Tsawon zagayowar';

  @override
  String days(Object count) {
    return 'Kwanaki $count';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Matsakaicin adadin kwanaki tsakanin al\'adunku';

  @override
  String get lastPeriodDate => 'Ranar al\'ada ta Æ™arshe';

  @override
  String get whenLastBleeding => 'Lokacin da zubar jininku na Æ™arshe ya fara';

  @override
  String get ttcHistory => 'Tarihin TTC';

  @override
  String get faithPreference => 'ZaÉ“in addini';

  @override
  String get language => 'Harshe';

  @override
  String get audioGuidance => 'Jagorar sauti';

  @override
  String get agreeTerms => 'Na yarda da SharuÉ—É—a da Manufar Sirri';

  @override
  String get selectOption => 'ZaÉ“i zaÉ“i';

  @override
  String get home => 'Gida';

  @override
  String get calendar => 'Kalanda';

  @override
  String get learn => 'Koyi';

  @override
  String get todaysFertilityInsight => 'Basirar haihuwa ta yau';

  @override
  String get nextFertilityWindow => 'Tagar haihuwarku na gaba daga Dec 23';

  @override
  String get trackingBenefits =>
      'Ta hanyar bin haihuwarku kuna samun kyakkyawan fahimtar zagayowarku.';

  @override
  String get stayPositive =>
      'Kuna yin kyau! Ku kasance masu kyakkyawan tunani kuma ku mai da hankali!';

  @override
  String get learnHub => 'Wurin koyo';

  @override
  String get logSymptoms => 'Rubuta alamomin';

  @override
  String get bleeding => 'Zubar jini';

  @override
  String get mood => 'Yanayi';

  @override
  String get cervicalMucus => 'Ruwan cervical';

  @override
  String get pain => 'Ciwo';

  @override
  String get notes => 'Bayanai';

  @override
  String get loggedSymptoms => 'Alamomin da aka rubuta';

  @override
  String get educationalContentComingSoon =>
      'Abubuwan ilimi suna zuwa nan ba da jimawa ba';

  @override
  String get authInvalidEmail => 'Tsarin email bai dace ba';

  @override
  String get authInvalidPhone => 'Tsarin lambar waya bai dace ba';

  @override
  String get authPasswordTooShort =>
      'Kalmar sirri dole ta kasance aÆ™alla haruffa 8';

  @override
  String get authEmailAlreadyRegistered =>
      'An riga an yi rajista da wannan email';

  @override
  String get authPhoneAlreadyRegistered =>
      'An riga an yi rajista da wannan lambar waya';

  @override
  String get authInvalidOtpFormat => 'Tsarin OTP bai dace ba';

  @override
  String get authUserNotFound => 'Ba a sami mai amfani ba';

  @override
  String get authNoUserLoggedIn => 'Babu mai amfani da ya shiga';

  @override
  String get welcomeBack => 'Barka da dawowa';

  @override
  String get logInToAccount => 'Shiga cikin asusun ku';

  @override
  String get emailAddress => 'Adireshin email';

  @override
  String get emailHintLogin => 'ku@misali.com';

  @override
  String get passwordLabel => 'Kalmar sirri';

  @override
  String get enterPassword => 'Shigar da kalmar sirri';

  @override
  String get forgotPassword => 'Ka manta da kalmar sirri?';

  @override
  String get logIn => 'Shiga';
}



