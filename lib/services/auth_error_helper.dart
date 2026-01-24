import 'package:flutter/material.dart';
import 'auth_exception.dart';

/// Helper function to translate auth error codes to error messages
String getAuthErrorMessage(BuildContext context, dynamic error) {
  if (error is AuthException) {
    switch (error.code) {
      case AuthErrorCodes.invalidEmail:
        return 'Invalid email address';
      case AuthErrorCodes.invalidPhone:
        return 'Invalid phone number';
      case AuthErrorCodes.passwordTooShort:
        return 'Password is too short';
      case AuthErrorCodes.emailAlreadyRegistered:
        return 'Email already registered';
      case AuthErrorCodes.phoneAlreadyRegistered:
        return 'Phone number already registered';
      case AuthErrorCodes.invalidOtpFormat:
        return 'Invalid OTP format';
      case AuthErrorCodes.userNotFound:
        return 'User not found';
      case AuthErrorCodes.noUserLoggedIn:
        return 'No user logged in';
      default:
        return error.toString();
    }
  }
  
  // Fallback for other exceptions
  return error.toString().replaceAll('Exception: ', '');
}



