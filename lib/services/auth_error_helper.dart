import 'package:flutter/material.dart';
import 'package:Fertipath/flutter_gen/gen_l10n/app_localizations.dart';
import 'auth_exception.dart';

/// Helper function to translate auth error codes to localized messages
String getAuthErrorMessage(BuildContext context, dynamic error) {
  final localizations = AppLocalizations.of(context)!;
  
  if (error is AuthException) {
    switch (error.code) {
      case AuthErrorCodes.invalidEmail:
        return localizations.authInvalidEmail;
      case AuthErrorCodes.invalidPhone:
        return localizations.authInvalidPhone;
      case AuthErrorCodes.passwordTooShort:
        return localizations.authPasswordTooShort;
      case AuthErrorCodes.emailAlreadyRegistered:
        return localizations.authEmailAlreadyRegistered;
      case AuthErrorCodes.phoneAlreadyRegistered:
        return localizations.authPhoneAlreadyRegistered;
      case AuthErrorCodes.invalidOtpFormat:
        return localizations.authInvalidOtpFormat;
      case AuthErrorCodes.userNotFound:
        return localizations.authUserNotFound;
      case AuthErrorCodes.noUserLoggedIn:
        return localizations.authNoUserLoggedIn;
      default:
        return error.toString();
    }
  }
  
  // Fallback for other exceptions
  return error.toString().replaceAll('Exception: ', '');
}

