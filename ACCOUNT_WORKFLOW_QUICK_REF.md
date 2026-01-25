# Account Workflow - Quick Reference Guide

## 📁 Project Structure

```
lib/
├── screens/
│   └── onboarding/
│       ├── splash_screen.dart                 (Entry point)
│       ├── welcome_screen.dart                (Choose action)
│       ├── language_selection_screen.dart     (Pick language)
│       ├── account_type_selection_screen.dart (Email vs Phone)
│       ├── email_signup_screen.dart          (Email registration)
│       ├── phone_signup_screen.dart          (Phone registration)
│       ├── profile_setup_screen.dart         (Complete profile)
│       ├── login_screen.dart                 (Existing users)
│       └── forget_password_flow.dart         (Password recovery)
├── services/
│   ├── auth_service.dart                     (Main auth logic)
│   ├── auth_error_helper.dart               (Error handling)
│   ├── localization_provider.dart           (Language)
│   └── api_service.dart                     (API calls)
├── models/
│   ├── user.dart                            (User data model)
│   └── auth_exception.dart                  (Custom exceptions)
├── config/
│   └── app_config.dart                      (Settings)
└── main.dart                                 (Routes setup)

docs/
├── ACCOUNT_WORKFLOW_GUIDE.md                (Complete guide)
├── ACCOUNT_WORKFLOW_IMPLEMENTATION.md       (Code examples)
└── ACCOUNT_WORKFLOW_DIAGRAMS.md             (Visual flows)
```

---

## 🚀 Quick Start

### 1. Setup Dependencies
```bash
flutter pub get
```

### 2. Update pubspec.yaml
Already done! Added `email_validator: ^2.1.17`

### 3. Run the App
```bash
flutter run
```

### 4. Navigate the Workflow
- Start at Welcome Screen
- Choose Create Account
- Select Language (optional)
- Choose Email or Phone
- Complete signup
- Fill profile
- Access home screen

---

## 📋 Workflow Stages at a Glance

| Stage | File | Description |
|-------|------|-------------|
| 1 | splash_screen.dart | 2-sec delay, check auth status |
| 2 | welcome_screen.dart | Choose signup or login |
| 3 | language_selection_screen.dart | Select app language |
| 4a | account_type_selection_screen.dart | Choose email or phone |
| 5a | email_signup_screen.dart | Email-based registration |
| 5b | phone_signup_screen.dart | Phone-based registration |
| 5b-otp | verification_modal.dart | OTP verification (phone) |
| 6 | profile_setup_screen.dart | Health profile details |
| 7 | home_screen.dart | Main app (after signup) |

---

## 🔐 Key Authentication Methods

### Email Signup
```dart
Future<User?> signUpWithEmail({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String username,
})
```

### Phone Signup
```dart
Future<User?> signUpWithPhone({
  required String phoneNumber,
  String? email,
  String? username,
  String? firstName,
  String? lastName,
  String? password,
  String? preferredLanguage,
})
```

### OTP Verification
```dart
Future<User?> verifyPhoneOTP(String phoneNumber, String otp)
Future<void> resendPhoneOTP(String phoneNumber)
```

### Profile Update
```dart
Future<void> updateUserProfile(Map<String, dynamic> updates)
```

---

## 📱 UI Components Checklist

### Email Signup Screen
- [ ] Full Name field (validation: 2+ words)
- [ ] Email field (validation: valid email)
- [ ] Username field (validation: 3+ chars)
- [ ] Password field (validation: 8+ chars)
- [ ] Confirm Password field (matching)
- [ ] Show/hide password toggles
- [ ] Terms & Conditions checkbox
- [ ] Create Account button
- [ ] Sign In link (route to login)

### Phone Signup Screen
- [ ] Full Name field
- [ ] Email field (optional)
- [ ] Phone Number field (validation: valid format)
- [ ] Username field
- [ ] Password field
- [ ] Confirm Password field
- [ ] Show/hide toggles
- [ ] Submit button
- [ ] Cancel button

### OTP Verification Modal
- [ ] 4 x digit input fields
- [ ] Auto-advance between fields
- [ ] Countdown timer (5:00 → 0:00)
- [ ] Verify button
- [ ] Resend button
- [ ] Attempt counter (3 max)
- [ ] Error messages
- [ ] Disable submit on timeout

### Profile Setup Screen
- [ ] Age dropdown (18-90)
- [ ] Cycle Length dropdown (1-30)
- [ ] Period Length dropdown (1-14)
- [ ] Last Period Date picker
- [ ] TTC History dropdown
- [ ] Faith Preference dropdown
- [ ] Language dropdown
- [ ] Audio Guidance toggle
- [ ] Terms checkbox
- [ ] Submit button
- [ ] Progress bar

---

## 🛣️ Navigation Routes

```dart
// Main routes
'/'                → SplashScreen
'/welcome'         → WelcomeScreen
'/language'        → LanguageSelectionScreen
'/account-type'    → AccountTypeSelectionScreen
'/signup-email'    → EmailSignupScreen
'/signup-phone'    → PhoneSignupScreen
'/profile-setup'   → ProfileSetupScreen
'/home'            → HomeScreen
'/login'           → LoginScreen

// Password recovery
'/forgot-password'     → ForgotPasswordScreen
'/reset-password'      → ResetPasswordScreen
'/password-updated'    → PasswordUpdatedScreen
```

---

## 🎯 Form Validation Rules

### Email Signup

| Field | Rules |
|-------|-------|
| Full Name | Min 2 words, required |
| Email | Valid email format, unique |
| Username | 3-20 chars, alphanumeric, unique |
| Password | 8+ chars, uppercase, lowercase, number |
| Confirm | Must match password |
| Terms | Must be checked |

### Phone Signup

| Field | Rules |
|-------|-------|
| Phone | Valid format (+xxx... or 10-11 digits) |
| Email | Valid format (optional but recommended) |
| Username | 3-20 chars, alphanumeric, unique |
| Password | 8+ chars, uppercase, lowercase, number |
| Same as email signup | — |

### Profile Setup

| Field | Rules |
|-------|-------|
| Age | 18-90 years |
| Cycle Length | 1-30 days |
| Period Length | 1-14 days |
| Last Period Date | Any valid date (can be approximate) |
| TTC History | Select from predefined options |
| Faith Preference | Select from options |
| Language | Select from supported languages |
| Terms | Must be checked |

---

## ⚙️ API Endpoints

### Authentication
```
POST   /auth/signup/email
POST   /auth/signup/phone
POST   /auth/verify-otp
POST   /auth/resend-otp
POST   /auth/login
POST   /auth/logout
POST   /auth/refresh-token
```

### Validation
```
GET    /auth/check-email?email=...
GET    /auth/check-username?username=...
GET    /auth/check-phone?phone=...
```

### User Management
```
GET    /user/profile
PUT    /user/profile/{userId}
POST   /user/verify-email
```

---

## 🔄 Data Flow Summary

### Email Path
```
User Input → Validation → API Call → Save User 
  → Update State → Navigate to Profile → Store Data 
  → Navigate to Home
```

### Phone Path
```
User Input → Validation → API Call (Send OTP) 
  → Show OTP Modal → User Enters OTP → API Verify 
  → Create Account → Navigate to Profile → Store Data 
  → Navigate to Home
```

---

## 🎨 Styling & Colors

### Primary Colors
- **Green**: `Color(0xFF2E683D)` - Main brand color
- **Purple**: `Colors.deepPurple` - Alternative
- **Light Green**: `Colors.deepPurple.shade50`

### Text Styles
- **Title**: 24px, bold, deep purple
- **Subtitle**: 16px, medium, grey
- **Label**: 14px, regular
- **Input**: 14px, regular

### Spacing (Padding/Margin)
- **Large**: 32px
- **Medium**: 24px
- **Standard**: 16px
- **Small**: 8px

---

## 🧪 Testing Checklist

### Email Signup
- [ ] Valid email creates account
- [ ] Duplicate email shows error
- [ ] Weak password rejected
- [ ] Password mismatch shows error
- [ ] Terms must be accepted
- [ ] All validations work

### Phone Signup
- [ ] Valid phone format accepted
- [ ] Invalid format rejected
- [ ] OTP sent successfully
- [ ] OTP verified correctly
- [ ] Invalid OTP shows error
- [ ] Resend limits enforced

### Profile Setup
- [ ] All fields optional (except terms)
- [ ] Date picker works
- [ ] Dropdowns functional
- [ ] Data persists

### Cross-Platform
- [ ] Android: works correctly
- [ ] iOS: works correctly
- [ ] Responsive layout
- [ ] Dark mode compatible

---

## 🐛 Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| OTP not sent | Check SMS service config, verify phone format |
| Navigation fails | Ensure routes in main.dart |
| Form validation not working | Check TextFormField validators |
| AuthService not updating | Call notifyListeners() |
| SharedPreferences empty | Check init order, permissions |
| Email validation strict | Using email_validator package |
| Password too strict | 8+ chars, must have upper/lower/number |

---

## 🚨 Error Messages

### User Input Errors
- "Full name is required"
- "Please enter first and last name"
- "Enter a valid email"
- "Email already registered"
- "Username must be 3+ characters"
- "Username already taken"
- "Password must be 8+ characters"
- "Passwords do not match"

### OTP Errors
- "OTP has expired"
- "Invalid OTP"
- "Maximum resend attempts reached"

### Network Errors
- "Check your internet connection"
- "Failed to create account"
- "Server error, try again"

---

## 📊 State Variables Tracked

```dart
// AuthService
User? _currentUser
StreamController<User?> _authStateController
String _phoneNumberPendingVerification
DateTime _otpSentTime

// Email Signup
TextEditingController fullNameController
TextEditingController emailController
TextEditingController usernameController
TextEditingController passwordController
TextEditingController confirmPasswordController
bool showPassword
bool showConfirmPassword
bool agreeToTerms

// Phone Signup
// (Same as email) +
TextEditingController phoneController

// Profile Setup
int age
int cycleLength
int periodLength
DateTime? lastPeriodDate
String? ttcHistory
String? faithPreference
String language
bool audioGuidance
bool acceptTerms

// OTP Modal
Timer countdownTimer
int secondsRemaining (300)
int resendAttempts (0)
bool isVerifying
```

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| ACCOUNT_WORKFLOW_GUIDE.md | Complete workflow overview |
| ACCOUNT_WORKFLOW_IMPLEMENTATION.md | Code examples & integration |
| ACCOUNT_WORKFLOW_DIAGRAMS.md | Visual flow diagrams |
| ACCOUNT_WORKFLOW_QUICK_REF.md | This file - quick lookup |

---

## 🔗 Key File Links

- [Email Signup Screen](lib/screens/onboarding/email_signup_screen.dart)
- [Phone Signup Screen](lib/screens/onboarding/phone_signup_screen.dart)
- [Profile Setup Screen](lib/screens/onboarding/profile_setup_screen.dart)
- [Auth Service](lib/services/auth_service.dart)
- [Main Routes](lib/main.dart)

---

## 💡 Tips & Tricks

### 1. Testing Email Signup
Use test emails like:
- `test@example.com`
- `user+test@gmail.com`
- `firstname.lastname@domain.com`

### 2. Testing Phone Signup
Use formats:
- International: `+2348123456789`
- Local: `08123456789`
- With +: `+234 812 345 6789`

### 3. Simulating OTP
In development, you can:
- Log OTP in console
- Use test OTP: `1234`
- Check backend SMS logs

### 4. Testing Profile Setup
Min values:
- Age: 18
- Cycle: 21
- Period: 3
- Date: Any past date

### 5. Database Seeds
Create test accounts:
```
Email: test@example.com
Pass: Test@12345
Username: testuser
```

---

## 📞 Support & Debugging

### Enable Logging
```dart
// In auth_service.dart
debugPrint('Auth: signUpWithEmail - email: $email');
debugPrint('Auth: User created - id: ${user?.id}');
```

### Check SharedPreferences
```dart
// In console
final prefs = await SharedPreferences.getInstance();
prefs.reload();
print(prefs.getString('currentUser'));
```

### Monitor API Calls
```dart
// Use Network Analyzer or similar
// Check API responses in browser devtools
```

### Log OTP Flow
```dart
debugPrint('OTP: Sent to $phoneNumber');
debugPrint('OTP: Attempting verification with $otp');
debugPrint('OTP: Resend attempt ${_resendAttempts + 1}');
```

---

## 🎓 Learning Path

1. **Understand the Workflow**
   - Read ACCOUNT_WORKFLOW_GUIDE.md
   - Study ACCOUNT_WORKFLOW_DIAGRAMS.md

2. **Study the Code**
   - Review email_signup_screen.dart
   - Review phone_signup_screen.dart
   - Study auth_service.dart

3. **Implement Features**
   - Test email signup
   - Test phone signup
   - Test profile setup
   - Test navigation

4. **Add Enhancements**
   - Social login
   - Biometric auth
   - 2FA
   - Password strength meter

---

## ✅ Deployment Checklist

- [ ] Dependencies installed (flutter pub get)
- [ ] Email validator working
- [ ] All screens built
- [ ] Navigation routes configured
- [ ] AuthService implemented
- [ ] API endpoints updated
- [ ] Error handling in place
- [ ] Testing completed
- [ ] UI responsive
- [ ] Dark mode tested
- [ ] Permissions set (SMS, phone)
- [ ] Privacy policy updated
- [ ] Terms of service available

---

## 📞 Quick Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart

# Build release
flutter build apk

# Check for errors
flutter analyze

# Format code
dart format lib/
```

---

## 🎯 Next Steps After Signup

After account creation, users can:
1. Complete profile setup ✓
2. Access home screen ✓
3. Start tracking cycle
4. Join community
5. Access education content
6. Set up notifications
7. Connect with partner
8. Access support

---

*Last Updated: January 25, 2025*
*For detailed information, refer to the main documentation files*
