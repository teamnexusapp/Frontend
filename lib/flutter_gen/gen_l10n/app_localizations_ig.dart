import 'app_localizations.dart';
import 'package:intl/intl.dart' as intl;
// ignore: unused_import

// ignore_for_file: type=lint

/// The translations for Igbo (`ig`).
class AppLocalizationsIg extends AppLocalizations {
  AppLocalizationsIg([String locale = 'ig']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

  @override
  String get welcomeTitle => 'Nná»á» na Nexus Fertility';

  @override
  String get welcomeSubtitle => 'Onye enyemaka á»má»¥má»¥ gá»‹ nke onwe gá»‹';

  @override
  String get selectLanguage => 'Há»rá» Asá»¥sá»¥';

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
  String get next => 'Osote';

  @override
  String get back => 'Laghachi Azá»¥';

  @override
  String get skip => 'Mafee';

  @override
  String get done => 'Emechaa';

  @override
  String get createAccount => 'Mepá»¥ta Akaá»¥ntá»¥';

  @override
  String get signIn => 'Banye';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Ná»mba Ekwentá»‹';

  @override
  String get password => 'Paswá»á»dá»¥';

  @override
  String get confirmPassword => 'Kwenye Paswá»á»dá»¥';

  @override
  String get firstName => 'Aha Mbá»¥';

  @override
  String get lastName => 'Aha Ikpeazá»¥';

  @override
  String get dateOfBirth => 'á»¤bá»chá»‹ á»Œmá»¥má»¥';

  @override
  String get selectDate => 'Há»rá» á»¥bá»chá»‹';

  @override
  String get profilePicture => 'Foto Profaá»‹lá»¥';

  @override
  String get uploadPhoto => 'Bulite Foto';

  @override
  String get takePhoto => 'See Foto';

  @override
  String get chooseFromGallery => 'Há»rá» Site na Gallery';

  @override
  String get verifyEmail => 'Kwenye Email';

  @override
  String get verifyPhone => 'Kwenye Ekwentá»‹';

  @override
  String get enterOTP => 'Tinye OTP';

  @override
  String otpSentTo(String email) {
    return 'E zigara OTP na $email';
  }

  @override
  String get resendCode => 'Zigharia Koodu á»Œzá»';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Koodu ga-agwá»¥ na $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Biko tinye adreesá»‹ email ziri ezi';

  @override
  String get invalidPhone => 'Biko tinye ná»mba ekwentá»‹ ziri ezi';

  @override
  String get passwordMismatch => 'Paswá»á»dá»¥ adabaghá»‹';

  @override
  String get passwordTooShort =>
      'Paswá»á»dá»¥ ga-abá»¥rá»‹rá»‹ opekata mpe mkpá»¥rá»¥edemede 8';

  @override
  String get accountCreatedSuccessfully => 'E mepá»¥tara akaá»¥ntá»¥ nke á»ma!';

  @override
  String get profileSetupComplete => 'Ntá»ala profaá»‹lá»¥ zuru oke!';

  @override
  String get termsAndConditions => 'Ekwenyere m na Usoro na á»Œná»dá»¥';

  @override
  String get privacyPolicy => 'Ekwenyere m na Iwu Nzuzo';

  @override
  String get acceptTerms => 'Biko nabata usoro na á»ná»dá»¥';

  @override
  String get emailAlreadyExists => 'E debanyela email aha';

  @override
  String get phoneAlreadyExists => 'E debanyela ná»mba ekwentá»‹ aha';

  @override
  String get verificationFailed => 'Nkwenye dara ada. Biko nwaa á»zá»';

  @override
  String get tryAgain => 'Nwaa á»Œzá»';

  @override
  String get loading => 'Na-ebu...';

  @override
  String get error => 'Njehie';

  @override
  String get success => 'Ihe á»Šga Nke á»Œma';

  @override
  String get cancel => 'Kagbuo';

  @override
  String get save => 'Chekwa';

  @override
  String get logout => 'Pá»¥á»';

  @override
  String get genderMale => 'Nwoke';

  @override
  String get genderFemale => 'Nwanyá»‹';

  @override
  String get genderOther => 'Ndá»‹ á»Œzá»';

  @override
  String get selectGender => 'Há»rá» Okike';

  @override
  String get welcomeToJourney => 'Nná»á» na njem gá»‹';

  @override
  String get choosePreferredLanguage => 'Há»rá» asá»¥sá»¥ á»‹chá»rá»';

  @override
  String get choosePreferredMethod => 'Há»rá» á»¥zá» á»‹chá»rá»';

  @override
  String get createAccountWithEmail => 'Mepá»¥ta akaá»¥ntá»¥ site na email';

  @override
  String get createAccountWithPhone => 'Mepá»¥ta akaá»¥ntá»¥ site na ekwentá»‹';

  @override
  String get emailSignupTitle => 'Mepá»¥ta Akaá»¥ntá»¥ site na Email';

  @override
  String get emailSignupSubtitle => 'Tinye email na paswá»á»dá»¥ gá»‹';

  @override
  String get emailAddressLabel => 'Adreesá»‹ Email';

  @override
  String get emailHint => 'gi@example.com';

  @override
  String get emailRequired => 'Email dá»‹ mkpa';

  @override
  String get invalidEmailFormat => 'Usoro email ezighi ezi';

  @override
  String get passwordHint => 'Tinye paswá»á»dá»¥';

  @override
  String get passwordRequired => 'Paswá»á»dá»¥ dá»‹ mkpa';

  @override
  String get confirmPasswordHint => 'Kwenye paswá»á»dá»¥';

  @override
  String get confirmPasswordRequired => 'Biko kwenye paswá»á»dá»¥';

  @override
  String get phoneSignupTitle => 'Mepá»¥ta Akaá»¥ntá»¥ site na Ekwentá»‹';

  @override
  String get phoneSignupSubtitle => 'Anyá»‹ ga-ezigara gá»‹ OTP koodu';

  @override
  String get phoneNumberLabel => 'Ná»mba Ekwentá»‹';

  @override
  String get phoneNumberHint => 'Ná»mba ekwentá»‹';

  @override
  String get phoneRequired => 'Ekwentá»‹ dá»‹ mkpa';

  @override
  String get invalidPhoneForCountry => 'Ná»mba ekwentá»‹ ezighi ezi maka obodo a';

  @override
  String get otpInfoMessage =>
      'Anyá»‹ ga-ezigara gá»‹ OTP koodu iji kwenye ná»mba ekwentá»‹ gá»‹';

  @override
  String get continueText => 'Gaa n\'ihu';

  @override
  String get verifyEmailTitle => 'Kwenye Email';

  @override
  String get verifyPhoneTitle => 'Kwenye Ná»mba Ekwentá»‹';

  @override
  String codeSentToEmail(String email) {
    return 'Tinye koodu anyá»‹ zigara $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Tinye koodu anyá»‹ zigara $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Koodu ga-agwá»¥ na $time';
  }

  @override
  String get verify => 'Kwenye';

  @override
  String get didntReceiveCode => 'á»Š nataghá»‹ koodu? Zigharia á»zá»';

  @override
  String get enterAll6Digits => 'Biko tinye á»ná»¥á»gá»¥gá»¥ 6 niile';

  @override
  String get profile => 'Profaá»‹lá»¥';

  @override
  String get completeProfile => 'Ka mejue profaá»‹lá»¥ gá»‹';

  @override
  String get personalizeGuide =>
      'Nke a ga-enyere anyá»‹ aka ime ka ntuziaka gburugburu gá»‹ bá»¥rá»¥ nke gá»‹';

  @override
  String get age => 'Afá»';

  @override
  String get cycleLength => 'Ogologo okirikiri';

  @override
  String days(Object count) {
    return 'á»¤bá»chá»‹ $count';
  }

  @override
  String get averageDaysBetweenPeriods => 'á»Œná»¥á»gá»¥gá»¥ á»¥bá»chá»‹ n\'etiti nsá» gá»‹';

  @override
  String get lastPeriodDate => 'á»¤bá»chá»‹ nsá» ikpeazá»¥';

  @override
  String get whenLastBleeding => 'Mgbe á»bara nsá» gá»‹ ikpeazá»¥ malitere';

  @override
  String get ttcHistory => 'Aká»¥ká» TTC';

  @override
  String get faithPreference => 'Nhá»rá» okwukwe';

  @override
  String get language => 'Asá»¥sá»¥';

  @override
  String get audioGuidance => 'Ntuziaka á»dá»‹yo';

  @override
  String get agreeTerms => 'Ekwenyere m na Usoro na Iwu Nzuzo';

  @override
  String get selectOption => 'Há»rá» nhá»rá»';

  @override
  String get home => 'á»¤lá»';

  @override
  String get calendar => 'Kalenda';

  @override
  String get learn => 'Má»¥ta';

  @override
  String get todaysFertilityInsight => 'Nghá»ta á»‹má»¥ nwa taa';

  @override
  String get nextFertilityWindow =>
      'Windo á»‹má»¥ nwa gá»‹ na-esote sitere na Dec 23';

  @override
  String get trackingBenefits =>
      'Site n\'á»‹chá»pá»¥ta á»‹má»¥ nwa gá»‹, á»‹ na-enweta nghá»ta ka mma banyere okirikiri gá»‹.';

  @override
  String get stayPositive =>
      'á»Š na-eme nke á»ma! Ná»rá» na-adá»‹ mma ma lekwasá»‹ anya!';

  @override
  String get learnHub => 'Ebe mmá»¥ta';

  @override
  String get logSymptoms => 'Debanye aha ihe mgbaÃ mÃ ';

  @override
  String get bleeding => 'á»Œbara';

  @override
  String get mood => 'á»Œná»dá»¥ obi';

  @override
  String get cervicalMucus => 'Mmiri cervical';

  @override
  String get pain => 'Mgbu';

  @override
  String get notes => 'Ndetu';

  @override
  String get loggedSymptoms => 'Ihe mgbaÃ mÃ  edebanyere aha';

  @override
  String get educationalContentComingSoon =>
      'á»Œdá»‹naya mmá»¥ta na-abá»‹a n\'oge adá»‹ghá»‹ anya';

  @override
  String get authInvalidEmail => 'Usoro email ezighi ezi';

  @override
  String get authInvalidPhone => 'Usoro ná»mba ekwentá»‹ ezighi ezi';

  @override
  String get authPasswordTooShort =>
      'Paswá»á»dá»¥ ga-abá»¥rá»‹rá»‹ opekata mpe mkpá»¥rá»¥edemede 8';

  @override
  String get authEmailAlreadyRegistered => 'E debanyela email aha';

  @override
  String get authPhoneAlreadyRegistered => 'E debanyela ná»mba ekwentá»‹ aha';

  @override
  String get authInvalidOtpFormat => 'Usoro OTP ezighi ezi';

  @override
  String get authUserNotFound => 'Achá»taghá»‹ onye á»rá»¥';

  @override
  String get authNoUserLoggedIn => 'Onweghá»‹ onye á»rá»¥ banyere';

  @override
  String get welcomeBack => 'Nná»á» azá»¥';

  @override
  String get logInToAccount => 'Banye na akawá»¥ntá»¥ gá»‹';

  @override
  String get emailAddress => 'Adreesi email';

  @override
  String get emailHintLogin => 'gi@example.com';

  @override
  String get passwordLabel => 'Paswá»á»dá»¥';

  @override
  String get enterPassword => 'Tinye paswá»á»dá»¥';

  @override
  String get forgotPassword => 'á»Š chefuru paswá»á»dá»¥?';

  @override
  String get logIn => 'Banye';
}



