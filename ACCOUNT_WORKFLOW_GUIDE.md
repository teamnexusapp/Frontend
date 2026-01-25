# Account Workflow Guide

## Overview

This document outlines the complete account creation and authentication workflow for the Nexus Fertility App. The workflow is designed to provide a smooth user experience with multiple signup options, verification steps, and profile setup.

---

## Workflow Stages

### Stage 1: Welcome & Entry Points

**File**: `lib/screens/onboarding/welcome_screen.dart`

Users start at the Welcome screen with two primary options:
- **Create Your Account**: Routes to language selection
- **Log In**: Routes to login screen

#### Entry Points:
- Splash screen (auto-redirects to welcome after delay)
- Direct navigation via `/welcome` route

---

### Stage 2: Language Selection (Optional)

**File**: `lib/screens/onboarding/language_selection_screen.dart`

Users can select their preferred language for the app:
- English
- Yoruba
- Igbo
- Hausa
- Pidgin

**Navigation**: Routes to Account Type Selection after language is chosen

---

### Stage 3: Account Type Selection

**File**: `lib/screens/onboarding/account_type_selection_screen.dart`

Users choose their preferred method to create an account:

#### Option A: Email Signup
- Routes to Email Signup Screen
- Preferred for users with email preferences

#### Option B: Phone Signup
- Routes to Phone Signup Screen
- Preferred for users without email or mobile-first approach

---

### Stage 4A: Email Signup Flow

**File**: `lib/screens/onboarding/email_signup_screen.dart`

#### Required Fields:
1. **Full Name** (First and Last Name)
   - Validation: Must contain at least 2 words
   - Used for profile initialization

2. **Email Address**
   - Validation: Valid email format (using email_validator package)
   - Must be unique (checked during signup)

3. **Username**
   - Validation: Minimum 3 characters, alphanumeric
   - Must be unique across the platform

4. **Password**
   - Validation: Minimum 8 characters
   - Strength indicators recommended
   - Password must contain uppercase, lowercase, and numbers

5. **Confirm Password**
   - Must match the password field

#### Additional Requirements:
- Terms & Conditions acceptance checkbox
- Secure password confirmation

#### Success Flow:
1. Validates all form fields
2. Calls `AuthService.signUpWithEmail()`
3. Creates user account with provided credentials
4. Stores user data locally via SharedPreferences
5. Navigates to Profile Setup Screen

#### Error Handling:
- Shows inline validation errors
- Toast notifications for general errors
- Specific error messages for duplicate email/username

---

### Stage 4B: Phone Signup Flow

**File**: `lib/screens/onboarding/phone_signup_screen.dart`

#### Required Fields:
1. **Full Name** (same as email signup)
2. **Phone Number**
   - International format with country code
   - Validation: Valid phone format

3. **Email Address** (optional but recommended)
4. **Username**
5. **Password** & **Confirm Password**

#### OTP Verification Process:
1. After form submission, triggers `AuthService.signUpWithPhone()`
2. OTP sent to provided phone number
3. Displays OTP verification modal with 4 input fields
4. User enters 4-digit OTP
5. OTP verified via backend
6. User account created upon successful verification

#### OTP Modal Features:
- 4-digit input fields with auto-advance
- Auto-focus on next field
- Countdown timer for OTP expiry
- Resend OTP option
- Back button to edit phone number

#### Success Flow:
Same as email signup - routes to Profile Setup

---

### Stage 5: Profile Setup (Complete)

**File**: `lib/screens/onboarding/profile_setup_screen.dart`

This is the final step before accessing the main app. Users configure personal health information.

#### Required Profile Information:

1. **Age**
   - Dropdown: 18-90 years old
   - Used for personalized health recommendations

2. **Cycle Length**
   - Dropdown: 1-30 days
   - Default: 28 days
   - Used for period predictions

3. **Period Length**
   - Dropdown: 1-14 days
   - Default: 5 days
   - Used for cycle calculations

4. **Last Period Date**
   - Date picker
   - Can be approximate
   - Used as baseline for cycle tracking

5. **TTC (Trying to Conceive) History**
   - Dropdown options:
     - Trying to Conceive
     - Trying to Conceive - Default
     - Preparing to conceive
     - Just tracking my cycle
     - TTC 6+ months
     - TTC 12+ months
     - Using fertility treatment
     - Prefer not to say

6. **Faith Preference**
   - Dropdown options:
     - Christian
     - Muslim
     - Traditionalist
     - Neutral
   - Used for content personalization

7. **Language Selection**
   - Dropdown: English, Yoruba, Igbo, Hausa, Pidgin
   - Can be changed from initial selection

8. **Audio Guidance**
   - Toggle switch
   - Enables/disables audio features

9. **Terms & Conditions**
   - Must accept to continue
   - Checkbox validation

#### Submission:
- Validates all required fields
- Stores profile data in SharedPreferences
- Updates user profile via `AuthService.updateUserProfile()`
- Shows success message
- Routes to Home Screen

---

## Authentication Service

**File**: `lib/services/auth_service.dart`

### Key Methods:

```dart
// Email signup
Future<User?> signUpWithEmail({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String username,
})

// Phone signup
Future<User?> signUpWithPhone({
  required String phoneNumber,
  String? email,
  String? username,
  String? firstName,
  String? lastName,
  String? password,
  String? preferredLanguage,
})

// OTP verification
Future<User?> verifyEmailOTP(String email, String otp)
Future<User?> verifyPhoneOTP(String phoneNumber, String otp)

// Resend OTP
Future<void> resendEmailOTP(String email)
Future<void> resendPhoneOTP(String phoneNumber)

// Profile updates
Future<void> updateUserProfile(Map<String, dynamic> updates)

// Current user
User? getCurrentUser()
Stream<User?> authStateChanges()
```

---

## Data Models

### User Model

**File**: `lib/models/user.dart`

```dart
class User {
  final String id;
  final String email;
  final String? phoneNumber;
  final String firstName;
  final String lastName;
  final String username;
  final String? avatar;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final bool emailVerified;
  final bool phoneVerified;
  final Map<String, dynamic> profileData;
  final String? preferredLanguage;
}
```

### Profile Data Structure

```dart
{
  'age': 27,
  'cycleLength': 28,
  'periodLength': 5,
  'lastPeriodDate': '2024-01-15',
  'ttcHistory': 'Trying to Conceive',
  'faithPreference': 'Christian',
  'language': 'English',
  'audioGuidance': false,
  'termsAccepted': true,
  'profileCompletedAt': '2024-01-20T10:30:00Z'
}
```

---

## Navigation Routes

```dart
'/welcome'              → WelcomeScreen
'/language'            → LanguageSelectionScreen
'/account-type'        → AccountTypeSelectionScreen
'/signup-email'        → EmailSignupScreen
'/signup-phone'        → PhoneSignupScreen
'/profile-setup'       → ProfileSetupScreen
'/home'                → HomeScreen
'/login'               → LoginScreen
'/forgot-password'     → ForgotPasswordScreen
'/reset-password'      → ResetPasswordScreen
'/password-updated'    → PasswordUpdatedScreen
```

---

## State Management

### Provider Structure

**AuthService** (ChangeNotifier)
- Manages authentication state
- Stores current user
- Emits auth state changes
- Handles credential validation
- Manages token refresh

### Data Persistence

**SharedPreferences Keys**
- `currentUser`: Cached user object (JSON)
- `userProfile`: User profile data
- `selectedLanguage`: Language preference
- `authToken`: Authentication token (if applicable)
- `refreshToken`: Refresh token (if applicable)

---

## Error Handling

### Common Errors

1. **Duplicate Email**
   - Message: "Email already registered"
   - Action: Suggest password reset or different email

2. **Duplicate Username**
   - Message: "Username already taken"
   - Action: Suggest alternative username

3. **Weak Password**
   - Message: "Password must be 8+ characters with uppercase and numbers"
   - Action: Show password requirements

4. **Invalid Phone**
   - Message: "Invalid phone number"
   - Action: Show phone format example

5. **OTP Expired**
   - Message: "OTP expired, please request a new one"
   - Action: Show resend button

6. **Network Error**
   - Message: "Check your internet connection"
   - Action: Retry button

### Error Helper

**File**: `lib/services/auth_error_helper.dart`

Provides standardized error messages and handling logic.

---

## Security Considerations

1. **Password Security**
   - Minimum 8 characters required
   - Never store plain text passwords
   - Use HTTPS for transmission
   - Implement password hashing on backend

2. **OTP Security**
   - 4-6 digit codes
   - Time-limited (5-10 minutes)
   - Rate limiting on resend attempts
   - Single use only

3. **Data Privacy**
   - Store sensitive data in secure storage
   - Never log credentials
   - Clear cache on logout
   - Encrypt stored user data

4. **Verification**
   - Email verification before account activation
   - Phone OTP for phone signup
   - Optional 2FA for additional security

---

## Testing Checklist

### Email Signup
- [ ] Valid email creation
- [ ] Duplicate email prevention
- [ ] Password validation
- [ ] Confirm password matching
- [ ] Form validation messages
- [ ] Terms acceptance required
- [ ] Successful account creation
- [ ] Navigation to profile setup

### Phone Signup
- [ ] Valid phone number format
- [ ] OTP sending
- [ ] OTP verification modal display
- [ ] 4-digit input handling
- [ ] Auto-advance between fields
- [ ] OTP expiry handling
- [ ] Resend OTP functionality
- [ ] Successful account creation after verification

### Profile Setup
- [ ] All dropdowns functional
- [ ] Date picker works
- [ ] Form validation
- [ ] Data persistence
- [ ] Navigation to home screen
- [ ] Profile data stored correctly

### Cross-Device
- [ ] Works on Android
- [ ] Works on iOS
- [ ] Responsive on different screen sizes
- [ ] Dark mode compatibility

---

## Future Enhancements

1. **Social Sign-Up**
   - Google authentication
   - Facebook authentication
   - Apple sign-in

2. **Advanced Profile**
   - Photo upload
   - Additional health metrics
   - Partner/family profiles

3. **Account Recovery**
   - Enhanced account recovery options
   - Security questions
   - Account deletion

4. **Biometric Authentication**
   - Fingerprint login
   - Face ID login
   - PIN backup

5. **Multi-Factor Authentication**
   - SMS 2FA
   - Email 2FA
   - Authenticator app support

---

## Deployment Notes

1. **Backend Preparation**
   - Ensure email verification endpoint ready
   - Phone OTP service configured
   - User creation endpoint tested

2. **Environment Setup**
   - Update API endpoints in config
   - Configure error logging
   - Set up monitoring

3. **App Store Requirements**
   - Privacy policy updated
   - Terms of service in place
   - Data handling policy clear

4. **Testing**
   - Test with real backend
   - Load testing for signup endpoints
   - Security penetration testing

---

## Quick Reference

| Screen | File | Purpose |
|--------|------|---------|
| Welcome | `welcome_screen.dart` | Entry point, choose auth method |
| Language | `language_selection_screen.dart` | Language preference |
| Account Type | `account_type_selection_screen.dart` | Email or phone signup |
| Email Signup | `email_signup_screen.dart` | Email-based registration |
| Phone Signup | `phone_signup_screen.dart` | Phone + OTP registration |
| Profile Setup | `profile_setup_screen.dart` | Health profile configuration |
| Login | `login_screen.dart` | Existing user login |

---

## Support & Troubleshooting

### Common Issues

**OTP Not Received**
- Verify phone number format
- Check SMS service status
- Implement resend limit
- Log OTP service errors

**Account Creation Fails**
- Check backend connectivity
- Verify field validation
- Review server logs
- Check database constraints

**Navigation Issues**
- Verify route definitions in main.dart
- Check named route parameters
- Ensure screens are properly registered

---

## Version History

- **v1.0** (Jan 2025): Initial account workflow implementation
  - Email signup
  - Phone signup with OTP
  - Profile setup
  - Basic validation

