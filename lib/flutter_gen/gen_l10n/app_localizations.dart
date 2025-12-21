import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_ig.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_yo.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ha'),
    Locale('ig'),
    Locale('pt'),
    Locale('yo')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Nexus Fertility'**
  String get appTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Nexus Fertility'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal fertility companion'**
  String get welcomeSubtitle;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @yoruba.
  ///
  /// In en, this message translates to:
  /// **'Yoruba'**
  String get yoruba;

  /// No description provided for @igbo.
  ///
  /// In en, this message translates to:
  /// **'Igbo'**
  String get igbo;

  /// No description provided for @hausa.
  ///
  /// In en, this message translates to:
  /// **'Hausa'**
  String get hausa;

  /// No description provided for @pidgin.
  ///
  /// In en, this message translates to:
  /// **'Pidgin'**
  String get pidgin;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get german;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @profilePicture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePicture;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @verifyPhone.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone'**
  String get verifyPhone;

  /// No description provided for @enterOTP.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOTP;

  /// Message shown after OTP is sent
  ///
  /// In en, this message translates to:
  /// **'OTP sent to {email}'**
  String otpSentTo(String email);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// Timer for OTP expiration
  ///
  /// In en, this message translates to:
  /// **'Code expires in {minutes}:{seconds}'**
  String codeExpires(String minutes, String seconds);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @profileSetupComplete.
  ///
  /// In en, this message translates to:
  /// **'Profile setup complete!'**
  String get profileSetupComplete;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get acceptTerms;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get emailAlreadyExists;

  /// No description provided for @phoneAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Phone number already registered'**
  String get phoneAlreadyExists;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed. Please try again'**
  String get verificationFailed;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @welcomeToJourney.
  ///
  /// In en, this message translates to:
  /// **'Welcome to your journey'**
  String get welcomeToJourney;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get choosePreferredLanguage;

  /// No description provided for @choosePreferredMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred method'**
  String get choosePreferredMethod;

  /// No description provided for @createAccountWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Create account with email'**
  String get createAccountWithEmail;

  /// No description provided for @createAccountWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Create account with phone'**
  String get createAccountWithPhone;

  /// No description provided for @emailSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account with Email'**
  String get emailSignupTitle;

  /// No description provided for @emailSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password'**
  String get emailSignupSubtitle;

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmPasswordRequired;

  /// No description provided for @phoneSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account with Phone'**
  String get phoneSignupTitle;

  /// No description provided for @phoneSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will send you an OTP code'**
  String get phoneSignupSubtitle;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberHint;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneRequired;

  /// No description provided for @invalidPhoneForCountry.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number for this country'**
  String get invalidPhoneForCountry;

  /// No description provided for @otpInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send an OTP code to verify your phone number'**
  String get otpInfoMessage;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Phone Number'**
  String get verifyPhoneTitle;

  /// Message showing where OTP was sent
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to {email}'**
  String codeSentToEmail(String email);

  /// Message showing where OTP was sent
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to {phone}'**
  String codeSentToPhone(String phone);

  /// Timer showing code expiration
  ///
  /// In en, this message translates to:
  /// **'Code expires in {time}'**
  String codeExpiresIn(String time);

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? Resend'**
  String get didntReceiveCode;

  /// No description provided for @enterAll6Digits.
  ///
  /// In en, this message translates to:
  /// **'Please enter all 6 digits'**
  String get enterAll6Digits;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Let\'s complete your profile'**
  String get completeProfile;

  /// No description provided for @personalizeGuide.
  ///
  /// In en, this message translates to:
  /// **'This will help us personalize your cycle guide'**
  String get personalizeGuide;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @cycleLength.
  ///
  /// In en, this message translates to:
  /// **'Cycle Length'**
  String get cycleLength;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String days(Object count);

  /// No description provided for @averageDaysBetweenPeriods.
  ///
  /// In en, this message translates to:
  /// **'Average number of days between your periods'**
  String get averageDaysBetweenPeriods;

  /// No description provided for @lastPeriodDate.
  ///
  /// In en, this message translates to:
  /// **'Last Period Date'**
  String get lastPeriodDate;

  /// No description provided for @whenLastBleeding.
  ///
  /// In en, this message translates to:
  /// **'When your last menstrual bleeding started'**
  String get whenLastBleeding;

  /// No description provided for @ttcHistory.
  ///
  /// In en, this message translates to:
  /// **'TTC History'**
  String get ttcHistory;

  /// No description provided for @faithPreference.
  ///
  /// In en, this message translates to:
  /// **'Faith Preference'**
  String get faithPreference;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @audioGuidance.
  ///
  /// In en, this message translates to:
  /// **'Audio Guidance'**
  String get audioGuidance;

  /// No description provided for @agreeTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Conditions and Privacy Policy'**
  String get agreeTerms;

  /// No description provided for @selectOption.
  ///
  /// In en, this message translates to:
  /// **'Select option'**
  String get selectOption;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learn;

  /// No description provided for @todaysFertilityInsight.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Fertility Insight'**
  String get todaysFertilityInsight;

  /// No description provided for @nextFertilityWindow.
  ///
  /// In en, this message translates to:
  /// **'Your next fertility window is from Dec 23'**
  String get nextFertilityWindow;

  /// No description provided for @trackingBenefits.
  ///
  /// In en, this message translates to:
  /// **'By tracking your fertility you gain a better understanding of your cycle.'**
  String get trackingBenefits;

  /// No description provided for @stayPositive.
  ///
  /// In en, this message translates to:
  /// **'You\'re doing great! Stay positive and be focused!'**
  String get stayPositive;

  /// No description provided for @learnHub.
  ///
  /// In en, this message translates to:
  /// **'Learn Hub'**
  String get learnHub;

  /// No description provided for @logSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Log Symptoms'**
  String get logSymptoms;

  /// No description provided for @bleeding.
  ///
  /// In en, this message translates to:
  /// **'Bleeding'**
  String get bleeding;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @cervicalMucus.
  ///
  /// In en, this message translates to:
  /// **'Cervical Mucus'**
  String get cervicalMucus;

  /// No description provided for @pain.
  ///
  /// In en, this message translates to:
  /// **'Pain'**
  String get pain;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @loggedSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Logged Symptoms'**
  String get loggedSymptoms;

  /// No description provided for @educationalContentComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Educational content coming soon'**
  String get educationalContentComingSoon;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get authInvalidEmail;

  /// No description provided for @authInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get authInvalidPhone;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get authPasswordTooShort;

  /// No description provided for @authEmailAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get authEmailAlreadyRegistered;

  /// No description provided for @authPhoneAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Phone number already registered'**
  String get authPhoneAlreadyRegistered;

  /// No description provided for @authInvalidOtpFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP format'**
  String get authInvalidOtpFormat;

  /// No description provided for @authUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get authUserNotFound;

  /// No description provided for @authNoUserLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'No user logged in'**
  String get authNoUserLoggedIn;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @logInToAccount.
  ///
  /// In en, this message translates to:
  /// **'Log in to your account'**
  String get logInToAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHintLogin.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHintLogin;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'es',
        'fr',
        'ha',
        'ig',
        'pt',
        'yo'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ha':
      return AppLocalizationsHa();
    case 'ig':
      return AppLocalizationsIg();
    case 'pt':
      return AppLocalizationsPt();
    case 'yo':
      return AppLocalizationsYo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
