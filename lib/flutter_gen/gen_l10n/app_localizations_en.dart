// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertility';

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
  String get createAccount => 'Create Account';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get selectDate => 'Select date';

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
  String get profileSetupComplete => 'Profile setup complete!';

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
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

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
  String get choosePreferredMethod => 'Choose your preferred method';

  @override
  String get createAccountWithEmail => 'Create account with email';

  @override
  String get createAccountWithPhone => 'Create account with phone';

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
  String get continueText => 'Continue';

  @override
  String get verifyEmailTitle => 'Verify Email';

  @override
  String get verifyPhoneTitle => 'Verify Phone Number';

  @override
  String codeSentToEmail(String email) {
    return 'Enter the code we sent to $email';
  }

  @override
  String codeSentToPhone(String phone) {
    return 'Enter the code we sent to $phone';
  }

  @override
  String codeExpiresIn(String time) {
    return 'Code expires in $time';
  }

  @override
  String get verify => 'Verify';

  @override
  String get didntReceiveCode => 'Didn\'t receive code? Resend';

  @override
  String get enterAll6Digits => 'Please enter all 6 digits';

  @override
  String get profile => 'Profile';

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
  String get selectOption => 'Select option';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

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
  String get mood => 'Mood';

  @override
  String get cervicalMucus => 'Cervical Mucus';

  @override
  String get pain => 'Pain';

  @override
  String get notes => 'Notes';

  @override
  String get loggedSymptoms => 'Logged Symptoms';

  @override
  String get educationalContentComingSoon => 'Educational content coming soon';

  @override
  String get authInvalidEmail => 'Invalid email format';

  @override
  String get authInvalidPhone => 'Invalid phone number format';

  @override
  String get authPasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get authEmailAlreadyRegistered => 'Email already registered';

  @override
  String get authPhoneAlreadyRegistered => 'Phone number already registered';

  @override
  String get authInvalidOtpFormat => 'Invalid OTP format';

  @override
  String get authUserNotFound => 'User not found';

  @override
  String get authNoUserLoggedIn => 'No user logged in';

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
