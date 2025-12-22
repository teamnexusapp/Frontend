// Auth exception with error codes for localization
class AuthException implements Exception {
  final String code;
  final String? details;

  AuthException(this.code, {this.details});

  @override
  String toString() => details != null ? '$code: $details' : code;
}

// Auth error codes
class AuthErrorCodes {
  static const String invalidEmail = 'AUTH_INVALID_EMAIL';
  static const String invalidPhone = 'AUTH_INVALID_PHONE';
  static const String passwordTooShort = 'AUTH_PASSWORD_TOO_SHORT';
  static const String emailAlreadyRegistered = 'AUTH_EMAIL_ALREADY_REGISTERED';
  static const String phoneAlreadyRegistered = 'AUTH_PHONE_ALREADY_REGISTERED';
  static const String invalidOtpFormat = 'AUTH_INVALID_OTP_FORMAT';
  static const String userNotFound = 'AUTH_USER_NOT_FOUND';
  static const String noUserLoggedIn = 'AUTH_NO_USER_LOGGED_IN';
  static const String invalidCredentials = 'AUTH_INVALID_CREDENTIALS';
  static const String accountDisabled = 'AUTH_ACCOUNT_DISABLED';
  static const String serverError = 'AUTH_SERVER_ERROR';
}

