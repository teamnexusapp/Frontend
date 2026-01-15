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
  String get welcome => 'Welcome';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

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
  String get selectLanguage => 'Select Language';

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
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get loading => 'Loading...';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get selectOption => 'Please select an option';

  @override
  String get verifyPhoneTitle => 'Verify Phone Number';

  @override
  String codeSentToPhone(String phone) {
    return 'A verification code has been sent to $phone';
  }

  @override
  String codeExpiresIn(int minutes) {
    return 'Code expires in $minutes minutes';
  }

  @override
  String get verify => 'Verify';

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String get choosePreferredMethod => 'Choose your preferred signup method';

  @override
  String get createAccountWithEmail => 'Create account with Email';

  @override
  String get createAccountWithPhone => 'Create account with Phone';

  @override
  String get selectDate => 'Select Date';

  @override
  String get continueText => 'Continue';

  @override
  String get profileSetupComplete => 'Profile setup complete!';

  @override
  String get supportHub => 'Support Hub';

  @override
  String get dailyAffirmation => 'Daily Affirmation';

  @override
  String get stayPositive => 'Stay positive and believe in yourself';

  @override
  String get exploreCommunityGroups => 'Explore Community Groups';

  @override
  String get chooseSupportMode => 'Choose Your Support Mode';
}
