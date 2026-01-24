# API Integration Status

**Backend URL**: `https://fertipath-fastapi.onrender.com`

## ✅ Fully Integrated Screens

### Authentication & Onboarding
- **Login Screen** (`lib/screens/onboarding/login_screen.dart`)
  - POST `/auth/login` - Email/password login
  - Fetches profile after login to check completeness
  - Routes to profile setup or home based on profile status

- **Registration Screen** (`lib/screens/onboarding/registration_screen.dart`)
  - POST `/auth/send-otp` - Send OTP for registration
  - POST `/auth/verify-otp` - Verify OTP
  - Full user registration flow

- **Forgot Password** (`lib/screens/onboarding/forget_password_flow.dart`)
  - POST `/auth/forgot-password` - Request reset link
  
- **Reset Password** (`lib/screens/onboarding/reset_password_screen.dart`)
  - POST `/auth/reset-password` - Reset with token

### Profile Management
- **Profile Setup Screen** (`lib/screens/onboarding/profile_setup_screen.dart`)
  - POST `/api/update-profile` - Set cycle, period, age, preferences
  
- **Profile Setup (Edit)** (`lib/screens/profile/profile_setup_screen.dart`)
  - POST `/api/update-profile` - Update profile data
  
- **Profile Screen** (`lib/screens/profile/profile_screen.dart`)
  - GET `/api/profile` - Fetch user profile
  - GET `/api/user` - Fetch user details
  - DELETE `/api/user` - Delete account

### Tracking & Calendar
- **Calendar Tab Screen** (`lib/screens/calendar_tab_screen.dart`)
  - GET `/insights/insights` - Fetch cycle insights, predictions
  - Displays fertile period, next period, ovulation day
  
- **Log Symptom Screen** (`lib/screens/tracking/log_symptom_screen.dart`)
  - GET `/api/profile` - Fetch cycle data
  - POST `/insights/insights` - Log symptoms

### Predictions & Insights
- **Home Screen** (`lib/screens/home_screen.dart`)
  - GET `/api/profile` - Fetch user profile
  - POST `/insights/post-insights` - Send cycle data
  - GET `/insights/insights` - Fetch personalized insights
  
- **Gender Prediction Screen** (`lib/screens/gender_prediction_screen.dart`)
  - GET `/insights/insights` - Fetch ovulation day for predictions

### Support
- **Support Screen** (`lib/screens/support/support_screen.dart`)
  - GET `/api/profile` - Fetch faith preference for affirmations

## API Service Features

### Authentication
- **Token Management**: Bearer token authentication
- **Token Persistence**: SharedPreferences storage
- **Auto-retry**: Server wake-up handling for cold starts
- **Singleton Pattern**: Single instance across app

### Headers
```dart
{
  'Content-Type': 'application/json; charset=utf-8',
  'Accept': 'application/json',
  'Authorization': 'Bearer {token}'  // When authenticated
}
```

### Available Endpoints

#### Authentication
- `POST /auth/send-otp` - Register & send OTP
- `POST /auth/verify-otp` - Verify email/phone OTP
- `POST /auth/login` - Email/password login
- `POST /auth/forgot-password` - Request password reset
- `POST /auth/reset-password` - Reset password with token

#### User Profile
- `GET /api/user` - Get user details
- `GET /api/profile` - Get user profile
- `POST /api/update-profile` - Update profile
- `DELETE /api/user` - Delete user account

#### Insights & Tracking
- `GET /insights/insights` - Get cycle insights
- `POST /insights/post-insights` - Post cycle data
- `POST /insights/insights` - Log symptoms

## Error Handling
- Network errors with user-friendly messages
- Token expiration handling
- Retry logic for server cold starts
- Fallback data for failed API calls

## Data Flow
1. User logs in → Token stored in SharedPreferences
2. All authenticated requests include Bearer token
3. Profile data cached in AuthService
4. Insights refreshed on home tab load
5. Symptoms logged immediately to backend

## Status: ✅ PRODUCTION READY
All screens properly integrated with backend API.
