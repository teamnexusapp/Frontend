// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appTitle => 'FertiPath';

  @override
  String get welcomeTitle => 'Welcome to Nexus Fertility';

  @override
  String get welcomeSubtitle => 'Your personal fertility companion';

  @override
  String get selectLanguage => 'Select Language';

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
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get createAccount => 'Ƙirƙiri Asusun';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Imel';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Kalmar wucewa';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get selectDate => 'Zaɓi Ranar';

  @override
  String get profilePicture => 'Profile Picture';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get verifyEmail => 'Verify Email';

  @override
  String get verifyPhone => 'Verify Phone';

  @override
  String get enterOTP => 'Enter OTP';

  @override
  String otpSentTo(String email) {
    return 'OTP sent to $email';
  }

  @override
  String get resendCode => 'Resend Code';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Code expires in $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get accountCreatedSuccessfully => 'Account created successfully!';

  @override
  String get profileSetupComplete => 'An kammala saita bayanin martaba';

  @override
  String get termsAndConditions => 'I agree to the Terms and Conditions';

  @override
  String get privacyPolicy => 'I agree to the Privacy Policy';

  @override
  String get acceptTerms => 'Please accept the terms and conditions';

  @override
  String get emailAlreadyExists => 'Email already registered';

  @override
  String get phoneAlreadyExists => 'Phone number already registered';

  @override
  String get verificationFailed => 'Verification failed. Please try again';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Kuskure';

  @override
  String get success => 'Nasara';

  @override
  String get cancel => 'Soke';

  @override
  String get save => 'Ajiye';

  @override
  String get logout => 'Logout';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get selectGender => 'Select Gender';

  @override
  String get welcomeToJourney => 'Welcome to your journey';

  @override
  String get choosePreferredLanguage => 'Choose your preferred language';

  @override
  String get choosePreferredMethod => 'Zaɓi hanyar da kake so';

  @override
  String get createAccountWithEmail => 'Ƙirƙiri asusu ta imel';

  @override
  String get createAccountWithPhone => 'Ƙirƙiri asusu ta waya';

  @override
  String get emailSignupTitle => 'Create Account with Email';

  @override
  String get emailSignupSubtitle => 'Enter your email and password';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get confirmPasswordRequired => 'Please confirm password';

  @override
  String get phoneSignupTitle => 'Create Account with Phone';

  @override
  String get phoneSignupSubtitle => 'We will send you an OTP code';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberHint => 'Phone number';

  @override
  String get phoneRequired => 'Phone is required';

  @override
  String get invalidPhoneForCountry => 'Invalid phone number for this country';

  @override
  String get otpInfoMessage =>
      'We\'ll send an OTP code to verify your phone number';

  @override
  String get continueText => 'Ci gaba';

  @override
  String get verifyEmailTitle => 'Verify Email';

  @override
  String get verifyPhoneTitle => 'Tabbatar da Lambar Waya';

  @override
  String codeSentToEmail(String email) {
    return 'Enter the code we sent to $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'An aika lambar zuwa $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Lambar za ta ƙare cikin $time';
  }

  @override
  String get verify => 'Tabbatar';

  @override
  String get didntReceiveCode => 'Ba ka samu lambar ba?';

  @override
  String get enterAll6Digits => 'Please enter all 6 digits';

  @override
  String get profile => 'Bayanin martaba';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get completeProfile => 'Let\'s complete your profile';

  @override
  String get personalizeGuide =>
      'This will help us personalize your cycle guide';

  @override
  String get age => 'Age';

  @override
  String get cycleLength => 'Cycle Length';

  @override
  String days(Object count) {
    return '$count Days';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Average number of days between your periods';

  @override
  String get lastPeriodDate => 'Last Period Date';

  @override
  String get whenLastBleeding => 'When your last menstrual bleeding started';

  @override
  String get ttcHistory => 'TTC History';

  @override
  String get faithPreference => 'Faith Preference';

  @override
  String get language => 'Language';

  @override
  String get audioGuidance => 'Audio Guidance';

  @override
  String get agreeTerms =>
      'I agree to the Terms and Conditions and Privacy Policy';

  @override
  String get selectOption => 'Zaɓi zaɓi';

  @override
  String get home => 'Gida';

  @override
  String get calendar => 'Kalanda';

  @override
  String get learn => 'Learn';

  @override
  String get todaysFertilityInsight => 'Today\'s Fertility Insight';

  @override
  String get nextFertilityWindow => 'Your next fertility window is from Dec 23';

  @override
  String get trackingBenefits =>
      'By tracking your fertility you gain a better understanding of your cycle.';

  @override
  String get stayPositive =>
      'You\'re doing great! Stay positive and be focused!';

  @override
  String get learnHub => 'Learn Hub';

  @override
  String get logSymptoms => 'Log Symptoms';

  @override
  String get bleeding => 'Bleeding';

  @override
  String get mood => 'Yanayi';

  @override
  String get cervicalMucus => 'Cervical Mucus';

  @override
  String get pain => 'Ciwo';

  @override
  String get notes => 'Bayanan';

  @override
  String get loggedSymptoms => 'Logged Symptoms';

  @override
  String get educationalContentComingSoon => 'Educational content coming soon';

  @override
  String get authInvalidEmail => 'Imel ɗin bai dace ba';

  @override
  String get authInvalidPhone => 'Lambar waya ba ta dace ba';

  @override
  String get authPasswordTooShort =>
      'Kalmar sirri dole ta kasance aƙalla haruffa 8';

  @override
  String get authEmailAlreadyRegistered =>
      'An riga an yi rajista da wannan imel';

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
  String get welcomeBack => 'Welcome Back';

  @override
  String get logInToAccount => 'Log in to your account';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHintLogin => 'you@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get logIn => 'Log In';
}
