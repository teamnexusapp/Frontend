// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Nexus Fertilidade';

  @override
  String get welcomeTitle => 'Bem-vindo ao Nexus Fertilidade';

  @override
  String get welcomeSubtitle => 'Seu companheiro pessoal de fertilidade';

  @override
  String get selectLanguage => 'Selecionar Idioma';

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
  String get next => 'Próximo';

  @override
  String get back => 'Voltar';

  @override
  String get skip => 'Pular';

  @override
  String get done => 'Concluído';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get signIn => 'Entrar';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Número de Telefone';

  @override
  String get password => 'Senha';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get firstName => 'Primeiro Nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get dateOfBirth => 'Data de Nascimento';

  @override
  String get selectDate => 'Selecionar Data';

  @override
  String get profilePicture => 'Foto de Perfil';

  @override
  String get uploadPhoto => 'Carregar Foto';

  @override
  String get takePhoto => 'Tirar Foto';

  @override
  String get chooseFromGallery => 'Escolher da Galeria';

  @override
  String get verifyEmail => 'Verificar Email';

  @override
  String get verifyPhone => 'Verificar Telefone';

  @override
  String get enterOTP => 'Digite o OTP';

  @override
  String otpSentTo(String email) {
    return 'OTP enviado para $email';
  }

  @override
  String get resendCode => 'Reenviar Código';

  @override
  String codeExpires(String minutes, String seconds) {
    return 'Código expira em $minutes:$seconds';
  }

  @override
  String get invalidEmail => 'Por favor, insira um endereço de email válido';

  @override
  String get invalidPhone => 'Por favor, insira um número de telefone válido';

  @override
  String get passwordMismatch => 'As senhas não coincidem';

  @override
  String get passwordTooShort => 'A senha deve ter pelo menos 8 caracteres';

  @override
  String get accountCreatedSuccessfully => 'Conta criada com sucesso!';

  @override
  String get profileSetupComplete =>
      'A configuração do seu perfil está completa';

  @override
  String get termsAndConditions => 'Concordo com os Termos e Condições';

  @override
  String get privacyPolicy => 'Concordo com a Política de Privacidade';

  @override
  String get acceptTerms => 'Por favor, aceite os termos e condições';

  @override
  String get emailAlreadyExists => 'Email já registrado';

  @override
  String get phoneAlreadyExists => 'Número de telefone já registrado';

  @override
  String get verificationFailed =>
      'Verificação falhou. Por favor, tente novamente';

  @override
  String get tryAgain => 'Tentar Novamente';

  @override
  String get loading => 'Carregando...';

  @override
  String get error => 'Erro';

  @override
  String get success => 'Sucesso';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get logout => 'Sair';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Feminino';

  @override
  String get genderOther => 'Outro';

  @override
  String get selectGender => 'Selecionar Gênero';

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
  String get cycleLength => 'Duração do Ciclo';

  @override
  String days(Object count) {
    return '$count Days';
  }

  @override
  String get averageDaysBetweenPeriods =>
      'Average number of days between your periods';

  @override
  String get lastPeriodDate => 'Data da Última Menstruação';

  @override
  String get whenLastBleeding => 'When your last menstrual bleeding started';

  @override
  String get ttcHistory => 'Histórico TTC';

  @override
  String get faithPreference => 'Preferência de Fé';

  @override
  String get language => 'Language';

  @override
  String get audioGuidance => 'Orientação de Áudio';

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
