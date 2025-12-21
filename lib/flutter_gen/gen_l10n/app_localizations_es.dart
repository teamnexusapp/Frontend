// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertilidad';

  @override
  String get welcomeTitle => 'Bienvenido a Nexus Fertilidad';

  @override
  String get welcomeSubtitle => 'Tu compañero personal de fertilidad';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

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
  String get next => 'Siguiente';

  @override
  String get back => 'Atrás';

  @override
  String get skip => 'Omitir';

  @override
  String get done => 'Hecho';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get phoneNumber => 'Número de Teléfono';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get dateOfBirth => 'Fecha de Nacimiento';

  @override
  String get selectDate => 'Seleccionar Fecha';

  @override
  String get profilePicture => 'Foto de Perfil';

  @override
  String get uploadPhoto => 'Subir Foto';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get chooseFromGallery => 'Elegir de la Galería';

  @override
  String get verifyEmail => 'Verificar Correo';

  @override
  String get verifyPhone => 'Verificar Teléfono';

  @override
  String get enterOTP => 'Ingrese OTP';

  @override
  String otpSentTo(String email) {
    return 'OTP enviado a $email';
  }

  @override
  String get resendCode => 'Reenviar Código';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'El código vence en $minutes:$seconds';
  }

  @override
  String get invalidEmail =>
      'Por favor, ingrese una dirección de correo válida';

  @override
  String get invalidPhone => 'Por favor, ingrese un número de teléfono válido';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get accountCreatedSuccessfully => '¡Cuenta creada exitosamente!';

  @override
  String get profileSetupComplete => 'Su configuración de perfil está completa';

  @override
  String get termsAndConditions => 'Acepto los Términos y Condiciones';

  @override
  String get privacyPolicy => 'Acepto la Política de Privacidad';

  @override
  String get acceptTerms => 'Por favor, acepte los términos y condiciones';

  @override
  String get emailAlreadyExists => 'Correo ya registrado';

  @override
  String get phoneAlreadyExists => 'Número de teléfono ya registrado';

  @override
  String get verificationFailed =>
      'Verificación fallida. Por favor, intente nuevamente';

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Femenino';

  @override
  String get genderOther => 'Otro';

  @override
  String get selectGender => 'Seleccionar Género';

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
  String get cycleLength => 'Duración del Ciclo';

  @override
  String days(Object count) {
    return '$count Days';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Average number of days between your periods';

  @override
  String get lastPeriodDate => 'Fecha de la Última Menstruación';

  @override
  String get whenLastBleeding => 'When your last menstrual bleeding started';

  @override
  String get ttcHistory => 'Historial TTC';

  @override
  String get faithPreference => 'Preferencia de Fe';

  @override
  String get language => 'Language';

  @override
  String get audioGuidance => 'Guía de Audio';

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
