// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Igbo (`ig`).
class AppLocalizationsIg extends AppLocalizations {
  AppLocalizationsIg([String locale = 'ig']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

  @override
  String get welcomeTitle => 'Nnọọ na Nexus Fertility';

  @override
  String get welcomeSubtitle => 'Onye enyemaka ọmụmụ gị nke onwe gị';

  @override
  String get selectLanguage => 'Họrọ Asụsụ';

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
  String get back => 'Laghachi Azụ';

  @override
  String get skip => 'Mafee';

  @override
  String get done => 'Emechaa';

  @override
  String get createAccount => 'Mepụta Akaụntụ';

  @override
  String get signIn => 'Banye';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Nọmba Ekwentị';

  @override
  String get password => 'Paswọọdụ';

  @override
  String get confirmPassword => 'Kwenye Paswọọdụ';

  @override
  String get firstName => 'Aha Mbụ';

  @override
  String get lastName => 'Aha Ikpeazụ';

  @override
  String get dateOfBirth => 'Ụbọchị Ọmụmụ';

  @override
  String get selectDate => 'Họrọ ụbọchị';

  @override
  String get profilePicture => 'Foto Profaịlụ';

  @override
  String get uploadPhoto => 'Bulite Foto';

  @override
  String get takePhoto => 'See Foto';

  @override
  String get chooseFromGallery => 'Họrọ Site na Gallery';

  @override
  String get verifyEmail => 'Kwenye Email';

  @override
  String get verifyPhone => 'Kwenye Ekwentị';

  @override
  String get enterOTP => 'Tinye OTP';

  @override
  String otpSentTo(String email) {
    return 'E zigara OTP na $email';
  }

  @override
  String get resendCode => 'Zigharia Koodu Ọzọ';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Koodu ga-agwụ na $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Biko tinye adreesị email ziri ezi';

  @override
  String get invalidPhone => 'Biko tinye nọmba ekwentị ziri ezi';

  @override
  String get passwordMismatch => 'Paswọọdụ adabaghị';

  @override
  String get passwordTooShort =>
      'Paswọọdụ ga-abụrịrị opekata mpe mkpụrụedemede 8';

  @override
  String get accountCreatedSuccessfully => 'E mepụtara akaụntụ nke ọma!';

  @override
  String get profileSetupComplete => 'Ntọala profaịlụ zuru oke!';

  @override
  String get termsAndConditions => 'Ekwenyere m na Usoro na Ọnọdụ';

  @override
  String get privacyPolicy => 'Ekwenyere m na Iwu Nzuzo';

  @override
  String get acceptTerms => 'Biko nabata usoro na ọnọdụ';

  @override
  String get emailAlreadyExists => 'E debanyela email aha';

  @override
  String get phoneAlreadyExists => 'E debanyela nọmba ekwentị aha';

  @override
  String get verificationFailed => 'Nkwenye dara ada. Biko nwaa ọzọ';

  @override
  String get tryAgain => 'Nwaa Ọzọ';

  @override
  String get loading => 'Na-ebu...';

  @override
  String get error => 'Njehie';

  @override
  String get success => 'Ihe Ịga Nke Ọma';

  @override
  String get cancel => 'Kagbuo';

  @override
  String get save => 'Chekwa';

  @override
  String get logout => 'Pụọ';

  @override
  String get genderMale => 'Nwoke';

  @override
  String get genderFemale => 'Nwanyị';

  @override
  String get genderOther => 'Ndị Ọzọ';

  @override
  String get selectGender => 'Họrọ Okike';

  @override
  String get welcomeToJourney => 'Nnọọ na njem gị';

  @override
  String get choosePreferredLanguage => 'Họrọ asụsụ ịchọrọ';

  @override
  String get choosePreferredMethod => 'Họrọ ụzọ ịchọrọ';

  @override
  String get createAccountWithEmail => 'Mepụta akaụntụ site na email';

  @override
  String get createAccountWithPhone => 'Mepụta akaụntụ site na ekwentị';

  @override
  String get emailSignupTitle => 'Mepụta Akaụntụ site na Email';

  @override
  String get emailSignupSubtitle => 'Tinye email na paswọọdụ gị';

  @override
  String get emailAddressLabel => 'Adreesị Email';

  @override
  String get emailHint => 'gi@example.com';

  @override
  String get emailRequired => 'Email dị mkpa';

  @override
  String get invalidEmailFormat => 'Usoro email ezighi ezi';

  @override
  String get passwordHint => 'Tinye paswọọdụ';

  @override
  String get passwordRequired => 'Paswọọdụ dị mkpa';

  @override
  String get confirmPasswordHint => 'Kwenye paswọọdụ';

  @override
  String get confirmPasswordRequired => 'Biko kwenye paswọọdụ';

  @override
  String get phoneSignupTitle => 'Mepụta Akaụntụ site na Ekwentị';

  @override
  String get phoneSignupSubtitle => 'Anyị ga-ezigara gị OTP koodu';

  @override
  String get phoneNumberLabel => 'Nọmba Ekwentị';

  @override
  String get phoneNumberHint => 'Nọmba ekwentị';

  @override
  String get phoneRequired => 'Ekwentị dị mkpa';

  @override
  String get invalidPhoneForCountry => 'Nọmba ekwentị ezighi ezi maka obodo a';

  @override
  String get otpInfoMessage =>
      'Anyị ga-ezigara gị OTP koodu iji kwenye nọmba ekwentị gị';

  @override
  String get continueText => 'Gaa n\'ihu';

  @override
  String get verifyEmailTitle => 'Kwenye Email';

  @override
  String get verifyPhoneTitle => 'Kwenye Nọmba Ekwentị';

  @override
  String codeSentToEmail(String email) {
    return 'Tinye koodu anyị zigara $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Tinye koodu anyị zigara $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Koodu ga-agwụ na $time';
  }

  @override
  String get verify => 'Kwenye';

  @override
  String get didntReceiveCode => 'Ị nataghị koodu? Zigharia ọzọ';

  @override
  String get enterAll6Digits => 'Biko tinye ọnụọgụgụ 6 niile';

  @override
  String get profile => 'Profaịlụ';

  @override
  String get completeProfile => 'Ka mejue profaịlụ gị';

  @override
  String get personalizeGuide =>
      'Nke a ga-enyere anyị aka ime ka ntuziaka gburugburu gị bụrụ nke gị';

  @override
  String get age => 'Afọ';

  @override
  String get cycleLength => 'Ogologo okirikiri';

  @override
  String days(Object count) {
    return 'Ụbọchị $count';
  }

  @override
  String get averageDaysBetweenPeriods => 'Ọnụọgụgụ ụbọchị n\'etiti nsọ gị';

  @override
  String get lastPeriodDate => 'Ụbọchị nsọ ikpeazụ';

  @override
  String get whenLastBleeding => 'Mgbe ọbara nsọ gị ikpeazụ malitere';

  @override
  String get ttcHistory => 'Akụkọ TTC';

  @override
  String get faithPreference => 'Nhọrọ okwukwe';

  @override
  String get language => 'Asụsụ';

  @override
  String get audioGuidance => 'Ntuziaka ọdịyo';

  @override
  String get agreeTerms => 'Ekwenyere m na Usoro na Iwu Nzuzo';

  @override
  String get selectOption => 'Họrọ nhọrọ';

  @override
  String get home => 'Ụlọ';

  @override
  String get calendar => 'Kalenda';

  @override
  String get learn => 'Mụta';

  @override
  String get todaysFertilityInsight => 'Nghọta ịmụ nwa taa';

  @override
  String get nextFertilityWindow =>
      'Windo ịmụ nwa gị na-esote sitere na Dec 23';

  @override
  String get trackingBenefits =>
      'Site n\'ịchọpụta ịmụ nwa gị, ị na-enweta nghọta ka mma banyere okirikiri gị.';

  @override
  String get stayPositive =>
      'Ị na-eme nke ọma! Nọrọ na-adị mma ma lekwasị anya!';

  @override
  String get learnHub => 'Ebe mmụta';

  @override
  String get logSymptoms => 'Debanye aha ihe mgbaàmà';

  @override
  String get bleeding => 'Ọbara';

  @override
  String get mood => 'Ọnọdụ obi';

  @override
  String get cervicalMucus => 'Mmiri cervical';

  @override
  String get pain => 'Mgbu';

  @override
  String get notes => 'Ndetu';

  @override
  String get loggedSymptoms => 'Ihe mgbaàmà edebanyere aha';

  @override
  String get educationalContentComingSoon =>
      'Ọdịnaya mmụta na-abịa n\'oge adịghị anya';

  @override
  String get authInvalidEmail => 'Usoro email ezighi ezi';

  @override
  String get authInvalidPhone => 'Usoro nọmba ekwentị ezighi ezi';

  @override
  String get authPasswordTooShort =>
      'Paswọọdụ ga-abụrịrị opekata mpe mkpụrụedemede 8';

  @override
  String get authEmailAlreadyRegistered => 'E debanyela email aha';

  @override
  String get authPhoneAlreadyRegistered => 'E debanyela nọmba ekwentị aha';

  @override
  String get authInvalidOtpFormat => 'Usoro OTP ezighi ezi';

  @override
  String get authUserNotFound => 'Achọtaghị onye ọrụ';

  @override
  String get authNoUserLoggedIn => 'Onweghị onye ọrụ banyere';

  @override
  String get welcomeBack => 'Nnọọ azụ';

  @override
  String get logInToAccount => 'Banye na akawụntụ gị';

  @override
  String get emailAddress => 'Adreesi email';

  @override
  String get emailHintLogin => 'gi@example.com';

  @override
  String get passwordLabel => 'Paswọọdụ';

  @override
  String get enterPassword => 'Tinye paswọọdụ';

  @override
  String get forgotPassword => 'Ị chefuru paswọọdụ?';

  @override
  String get logIn => 'Banye';
}
