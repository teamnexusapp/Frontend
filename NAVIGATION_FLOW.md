# Navigation Flow

## App Entry Point

The application now follows this navigation flow:

### 1. **Splash Screen** (Entry Point)
- **File**: [lib/screens/onboarding/splash_screen.dart](lib/screens/onboarding/splash_screen.dart)
- **Duration**: 2.5 seconds with animated zoom effect
- **Next**: Welcome Screen (`/welcome`)
- **Animation**: Zoom in (60%) → Zoom out (40%)

### 2. **Welcome Screen**
- **File**: [lib/screens/onboarding/welcome_screen.dart](lib/screens/onboarding/welcome_screen.dart)
- **Options**:
  - "Create Your Account" → Language Selection (`/language`)
  - "Log In" → Login Screen (`/login`)

### 3. **Login Screen**
- **File**: [lib/screens/onboarding/login_screen.dart](lib/screens/onboarding/login_screen.dart)
- **Flow**:
  - User enters email and password
  - Click "Login"
  - Backend authentication performed
  - On success → **Home Screen** (`/home`)
  - On error → Error message displayed

### 4. **Home Screen** (Main App)
- **File**: [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
- **Status**: Logged in, fully accessible app

---

## Configuration

The main entry point in [lib/main.dart](lib/main.dart) has been updated:

```dart
home: const SplashScreen(),
```

This ensures the splash screen displays first when the app launches.

---

## Route Mapping

All routes are defined in `main.dart` `onGenerateRoute` method:

| Route | Screen | Purpose |
|-------|--------|---------|
| `/` (home) | SplashScreen | Initial launch |
| `/welcome` | WelcomeScreen | Account creation or login choice |
| `/login` | LoginScreen | User authentication |
| `/language` | LanguageSelectionScreen | Select preferred language |
| `/forgot-password` | ForgotPasswordScreen | Password recovery |
| `/reset_password` | ResetPasswordScreen | Password reset with token |
| `/password-updated` | PasswordUpdatedScreen | Confirmation after reset |
| `/home` (default) | HomeScreen | Main app experience |

---

## Testing the Flow

To test the navigation flow:

1. **Launch app** → Splash screen appears with animation
2. **Wait 2.5 seconds** → Redirects to Welcome screen
3. **Click "Log In"** → Login screen appears
4. **Enter credentials and login** → Home screen loads
5. **Successful authentication** → User is in the main app

---

## Notes

- Splash screen uses route replacement (`pushReplacementNamed`) to prevent back navigation
- Login screen uses `pushNamedAndRemoveUntil` to remove login from stack after successful authentication
- All routes are properly defined in the `onGenerateRoute` method
