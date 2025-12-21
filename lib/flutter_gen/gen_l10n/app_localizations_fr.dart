// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertilité';

  @override
  String get welcomeTitle => 'Bienvenue sur Nexus Fertilité';

  @override
  String get welcomeSubtitle => 'Votre compagnon personnel de fertilité';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

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
  String get next => 'Suivant';

  @override
  String get back => 'Retour';

  @override
  String get skip => 'Passer';

  @override
  String get done => 'Terminé';

  @override
  String get createAccount => 'Créer un Compte';

  @override
  String get signIn => 'Se Connecter';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Numéro de Téléphone';

  @override
  String get password => 'Mot de Passe';

  @override
  String get confirmPassword => 'Confirmer le Mot de Passe';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get dateOfBirth => 'Date de Naissance';

  @override
  String get selectDate => 'Sélectionner la Date';

  @override
  String get profilePicture => 'Photo de Profil';

  @override
  String get uploadPhoto => 'Télécharger une Photo';

  @override
  String get takePhoto => 'Prendre une Photo';

  @override
  String get chooseFromGallery => 'Choisir depuis la Galerie';

  @override
  String get verifyEmail => 'Vérifier l\'Email';

  @override
  String get verifyPhone => 'Vérifier le Téléphone';

  @override
  String get enterOTP => 'Entrez l\'OTP';

  @override
  String otpSentTo(String email) {
    return 'OTP envoyé à $email';
  }

  @override
  String get resendCode => 'Renvoyer le Code';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Le code expire dans $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Veuillez entrer une adresse email valide';

  @override
  String get invalidPhone => 'Veuillez entrer un numéro de téléphone valide';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get accountCreatedSuccessfully => 'Compte créé avec succès!';

  @override
  String get profileSetupComplete =>
      'Votre configuration de profil est complète';

  @override
  String get termsAndConditions => 'J\'accepte les Conditions Générales';

  @override
  String get privacyPolicy => 'J\'accepte la Politique de Confidentialité';

  @override
  String get acceptTerms => 'Veuillez accepter les conditions générales';

  @override
  String get emailAlreadyExists => 'Email déjà enregistré';

  @override
  String get phoneAlreadyExists => 'Numéro de téléphone déjà enregistré';

  @override
  String get verificationFailed => 'Vérification échouée. Veuillez réessayer';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get loading => 'Chargement...';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get logout => 'Déconnexion';

  @override
  String get genderMale => 'Masculin';

  @override
  String get genderFemale => 'Féminin';

  @override
  String get genderOther => 'Autre';

  @override
  String get selectGender => 'Sélectionner le Genre';

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
  String get cycleLength => 'Durée du Cycle';

  @override
  String days(Object count) {
    return '$count Days';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Average number of days between your periods';

  @override
  String get lastPeriodDate => 'Date de la Dernière Menstruation';

  @override
  String get whenLastBleeding => 'When your last menstrual bleeding started';

  @override
  String get ttcHistory => 'Historique TTC';

  @override
  String get faithPreference => 'Préférence religieuse';

  @override
  String get language => 'Language';

  @override
  String get audioGuidance => 'Guide Audio';

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
