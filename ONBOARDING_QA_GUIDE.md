# Nexus Fertility App - Onboarding & Account Creation

## Project Overview

This Flutter application implements a comprehensive onboarding and account creation flow with multi-language support, email/phone verification, and user profile setup.

## Features Implemented

### 1. Multi-Language Support
- **Supported Languages**: English, Spanish, French, Portuguese
- **Language Selection**: First screen allows users to choose their preferred language
- **Dynamic Localization**: All UI text updates based on selected language
- **ARB Files**: Localization data stored in `lib/l10n/` directory

### 2. Account Creation
- **Email-based Signup**: Create account with email and password
- **Phone-based Signup**: Create account with phone number
- **Password Validation**: 
  - Minimum 8 characters required
  - Password confirmation validation
- **Email Validation**: RFC compliant email format validation

### 3. Email/Phone Verification
- **OTP Generation**: 6-digit one-time passwords
- **Email OTP**: Sent to user's email address
- **Phone OTP**: Sent via SMS to user's phone
- **Resend Functionality**: Ability to resend codes
- **Countdown Timer**: 5-minute expiration timer with visual feedback
- **Secure Verification**: Validates OTP before account activation

### 4. User Profile Setup
- **Profile Information**:
  - First Name
  - Last Name
  - Date of Birth
  - Gender selection
  - Profile Picture upload
- **Image Handling**:
  - Camera capture option
  - Gallery selection option
- **Terms & Conditions**: Users must accept T&C before completing signup
- **Form Validation**: All fields validated before submission

### 5. Authentication Service
- **Local Authentication**: SharedPreferences-based user storage
- **Auth State Management**: Provider package for state management
- **User Model**: Comprehensive user data model with JSON serialization
- **Session Management**: Login/logout functionality

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── user.dart                      # User model
│   └── auth_state.dart                # Auth state model
├── services/
│   ├── auth_service.dart              # Authentication business logic
│   └── localization_provider.dart     # Language management
├── screens/
│   └── onboarding/
│       ├── language_selection_screen.dart
│       ├── welcome_screen.dart
│       ├── account_type_selection_screen.dart
│       ├── email_signup_screen.dart
│       ├── phone_signup_screen.dart
│       ├── email_otp_verification_screen.dart
│       ├── phone_otp_verification_screen.dart
│       └── profile_setup_screen.dart
├── widgets/                           # Reusable widgets
└── l10n/                              # Localization files
    ├── app_en.arb
    ├── app_es.arb
    ├── app_fr.arb
    └── app_pt.arb

test/
└── auth_service_test.dart             # Unit tests
```

## Installation & Setup

### Prerequisites
- Flutter SDK 3.10.1 or higher
- Dart SDK 3.10.1 or higher
- iOS deployment target 11.0 or higher
- Android API level 21 or higher

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.0
  firebase_auth: ^4.17.0
  provider: ^6.4.0
  intl: ^0.19.0
  flutter_localizations:
    sdk: flutter
  shared_preferences: ^2.2.2
  get_it: ^7.6.0
  google_fonts: ^6.1.0
  animate_do: ^3.1.2
  image_picker: ^1.0.5
```

### Getting Started
```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test

# Build APK (Android)
flutter build apk --release

# Build IPA (iOS)
flutter build ios --release
```

## QA Testing Guide

### 1. Language Selection Testing
**Test Case 1.1**: Language Selection Screen
- [ ] Open app and verify language selection screen displays
- [ ] Verify all 4 language options are visible (English, Spanish, French, Portuguese)
- [ ] Click each language and verify UI changes language
- [ ] Verify navigation to Welcome screen after language selection

**Test Case 1.2**: Language Persistence
- [ ] Select a language and proceed through onboarding
- [ ] Verify all subsequent screens display in selected language
- [ ] Complete onboarding and return to home screen
- [ ] Verify selected language persists

### 2. Welcome Screen Testing
**Test Case 2.1**: Welcome Screen Display
- [ ] Verify welcome screen displays after language selection
- [ ] Check all UI elements are properly aligned and visible
- [ ] Verify feature items display with icons
- [ ] Verify "Get Started" button is clickable
- [ ] Verify "Sign In" link is present for existing users

### 3. Account Type Selection Testing
**Test Case 3.1**: Account Type Options
- [ ] Verify both Email and Phone options display
- [ ] Click Email option and verify navigation to email signup
- [ ] Go back and click Phone option and verify navigation to phone signup
- [ ] Verify proper icons for each option

### 4. Email Signup Testing
**Test Case 4.1**: Email Validation
- [ ] Leave email field empty and submit - should show error
- [ ] Enter invalid email formats:
  - [ ] "notanemail" - should show error
  - [ ] "user@" - should show error
  - [ ] "user@domain" - should show error
- [ ] Enter valid email "test@example.com" - should proceed

**Test Case 4.2**: Password Validation
- [ ] Leave password field empty - should show error
- [ ] Enter password less than 8 characters - should show error
- [ ] Enter 8+ character password - should proceed
- [ ] Enter password that doesn't match confirm password - should show error
- [ ] Enter matching passwords - should proceed

**Test Case 4.3**: Form Submission
- [ ] Fill all fields correctly
- [ ] Verify loading indicator appears during submission
- [ ] Verify navigation to Email OTP verification screen
- [ ] Test submitting with empty form - should show validation errors

### 5. Phone Signup Testing
**Test Case 5.1**: Phone Number Validation
- [ ] Leave phone field empty - should show error
- [ ] Enter invalid phone numbers:
  - [ ] "123" - should show error
  - [ ] "abc1234567" - should show error
- [ ] Enter valid phone numbers:
  - [ ] "+1 (555) 000-0000" - should proceed
  - [ ] "+44 20 7946 0958" - should proceed
  - [ ] "+33 1 42 68 53 00" - should proceed

**Test Case 5.2**: Country Code Selection
- [ ] Verify country code dropdown displays all options
- [ ] Change country code and verify it updates
- [ ] Verify selected country code appears in final phone number

**Test Case 5.3**: Form Submission
- [ ] Fill phone field correctly
- [ ] Click Continue button
- [ ] Verify navigation to Phone OTP verification screen
- [ ] Verify phone number displays correctly in OTP screen

### 6. Email OTP Verification Testing
**Test Case 6.1**: OTP Input
- [ ] Verify 6 OTP input fields display
- [ ] Enter digit in first field - focus should move to next field
- [ ] Try entering non-numeric characters - should not accept
- [ ] Clear fields and verify they remain empty

**Test Case 6.2**: Timer Functionality
- [ ] Verify 5-minute countdown timer displays
- [ ] Verify timer counts down every second
- [ ] Verify timer shows in MM:SS format
- [ ] Verify timer turns red when less than 60 seconds remain

**Test Case 6.3**: Code Verification
- [ ] Enter all 6 digits and click Verify
- [ ] Verify loading indicator appears
- [ ] Verify navigation to Profile Setup screen on success
- [ ] Test with incorrect OTP - should show error

**Test Case 6.4**: Resend Functionality
- [ ] Verify "Resend Code" button is disabled when timer is running
- [ ] Wait for timer to expire
- [ ] Verify "Resend Code" button becomes enabled
- [ ] Click resend and verify timer resets to 5 minutes
- [ ] Verify success message appears

### 7. Phone OTP Verification Testing
**Test Case 7.1**: OTP Input (same as email)
- [ ] Verify 6 OTP input fields display
- [ ] Enter digits and verify focus moves between fields
- [ ] Try entering non-numeric characters
- [ ] Verify manual field clearing works

**Test Case 7.2**: Timer and Resend (same as email)
- [ ] Verify countdown timer functionality
- [ ] Test resend button enable/disable logic
- [ ] Verify timer reset after resend

**Test Case 7.3**: Verification
- [ ] Enter OTP and click Verify
- [ ] Verify navigation to Profile Setup on success
- [ ] Test with incorrect OTP

### 8. Profile Setup Testing
**Test Case 8.1**: Profile Picture Upload
- [ ] Verify add photo button displays
- [ ] Click and verify camera/gallery options appear
- [ ] Select camera option (simulate if needed)
- [ ] Select gallery option (simulate if needed)
- [ ] Verify selected image displays in profile picture circle
- [ ] Upload works in both dark and light themes

**Test Case 8.2**: Form Fields Validation
- [ ] Leave all fields empty and submit - should show errors
- [ ] Enter only first name - should show "Last name required" error
- [ ] Enter first and last names but no date - should show "Date required" error
- [ ] Select all fields and verify form becomes valid

**Test Case 8.3**: Date of Birth Picker
- [ ] Click date field
- [ ] Verify date picker displays
- [ ] Select a date and verify it displays in correct format (DD/MM/YYYY)
- [ ] Verify past dates are selectable
- [ ] Verify future dates are not selectable

**Test Case 8.4**: Gender Selection
- [ ] Click gender dropdown
- [ ] Verify all options display (Male, Female, Other, Prefer not to say)
- [ ] Select each option and verify it updates
- [ ] Verify gender field is required

**Test Case 8.5**: Terms & Conditions
- [ ] Try submitting without accepting terms - should show error
- [ ] Check terms checkbox
- [ ] Verify "Complete Setup" button becomes enabled
- [ ] Submit form successfully

**Test Case 8.6**: Complete Setup
- [ ] Fill all fields correctly
- [ ] Verify loading indicator appears during submission
- [ ] Verify success message appears
- [ ] Verify navigation to Home screen
- [ ] Verify user data is saved

### 9. End-to-End Flow Testing
**Test Case 9.1**: Complete Email Signup Flow
- [ ] Start from language selection
- [ ] Select English
- [ ] Click "Get Started"
- [ ] Select Email signup
- [ ] Enter valid email and password
- [ ] Complete email OTP verification
- [ ] Complete profile setup
- [ ] Verify user is logged in and on home screen

**Test Case 9.2**: Complete Phone Signup Flow
- [ ] Start from language selection
- [ ] Select Spanish
- [ ] Click "Get Started"
- [ ] Select Phone signup
- [ ] Enter valid phone number
- [ ] Complete phone OTP verification
- [ ] Complete profile setup in Spanish
- [ ] Verify user is logged in and home screen is in Spanish

**Test Case 9.3**: Back Navigation
- [ ] Go through signup flow
- [ ] Click back button on each screen
- [ ] Verify navigation goes back to previous screen
- [ ] Verify data is preserved when going back and forward

### 10. Error Handling Testing
**Test Case 10.1**: Network Errors
- [ ] Disconnect internet and try signup
- [ ] Try OTP verification without connection
- [ ] Reconnect and retry
- [ ] Verify appropriate error messages display

**Test Case 10.2**: Validation Error Messages
- [ ] Test each validation rule
- [ ] Verify error messages are clear and in correct language
- [ ] Verify form doesn't submit with validation errors
- [ ] Verify error messages clear when field is corrected

### 11. UI/UX Testing
**Test Case 11.1**: Responsive Design
- [ ] Test on devices with different screen sizes
- [ ] Verify UI scales properly
- [ ] Verify text is readable on all screen sizes
- [ ] Verify buttons are easily tappable (min 48x48 dp)

**Test Case 11.2**: Dark Mode
- [ ] Enable dark mode (if implemented)
- [ ] Verify all screens display correctly
- [ ] Verify text contrast is sufficient
- [ ] Verify images display properly

**Test Case 11.3**: Accessibility
- [ ] Enable accessibility settings
- [ ] Verify all buttons have accessible labels
- [ ] Test with screen reader
- [ ] Verify focus order is logical

### 12. Performance Testing
**Test Case 12.1**: Load Time
- [ ] Measure time to display each screen
- [ ] Verify all screens load within 2 seconds
- [ ] Monitor memory usage during flow

**Test Case 12.2**: Battery Usage
- [ ] Monitor battery drain during longer operations
- [ ] Verify no excessive CPU usage
- [ ] Verify efficient data storage

## Known Issues & Workarounds

### Issue 1: Firebase Configuration
**Status**: Not configured in this version
**Workaround**: Currently using SharedPreferences for local storage. Configure Firebase for production use.

### Issue 2: Real OTP Service
**Status**: Mocked implementation
**Workaround**: Integrate with real SMS/Email service provider (Twilio, AWS SNS, etc.)

### Issue 3: Image Picker Permissions
**Status**: Need platform-specific permissions
**Fix**: Add permissions to AndroidManifest.xml and Info.plist

## Future Enhancements

1. **Firebase Integration**
   - Real authentication with Firebase Auth
   - Firestore for user data storage
   - Cloud Functions for OTP generation

2. **Push Notifications**
   - Send verification reminders
   - Notify users of account activities

3. **Biometric Authentication**
   - Fingerprint login
   - Face recognition support

4. **Enhanced Validation**
   - Real-time email verification
   - Phone number format validation per country
   - Password strength meter

5. **User Experience**
   - Progress indicators for multi-step flows
   - Animations between screens
   - Onboarding tutorials

## Testing Commands

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/auth_service_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode
flutter test --watch

# Run integration tests
flutter test integration_test/
```

## Support & Contact

For issues or questions about the onboarding flow:
- Create an issue in the repository
- Contact the development team
- Check documentation in the wiki

## License

This project is licensed under MIT License. See LICENSE file for details.
