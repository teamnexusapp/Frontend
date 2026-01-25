# Account Workflow - Visual Diagrams & Flow Maps

## 1. Complete Account Creation Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    SPLASH SCREEN                                │
│              (2 second delay)                                   │
└──────────────────┬──────────────────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
    User exists?          No user
        │                     │
        ▼                     ▼
    GO TO HOME          WELCOME SCREEN
                        (Entry point)
                             │
                    ┌────────┴────────┐
                    │                 │
              Create Account       Log In
                    │                 │
                    ▼                 ▼
          LANGUAGE SELECTION    LOGIN SCREEN
          (Optional)
                    │
                    ▼
          ACCOUNT TYPE SELECTION
                    │
        ┌───────────┴───────────┐
        │                       │
      EMAIL                   PHONE
        │                       │
        ▼                       ▼
   EMAIL SIGNUP        PHONE SIGNUP
   SCREEN              SCREEN
        │                       │
        │              ┌────────┘
        │              │
        │              ▼
        │         OTP VERIFICATION
        │         MODAL (Show OTP inputs)
        │              │
        │         ┌────┴────┐
        │         │          │
        │      Valid      Invalid
        │         │          │
        │         │      Resend/Retry
        │         │          │
        └────┬────┴──────────┘
             │
             ▼
      PROFILE SETUP SCREEN
      (Complete profile)
             │
        ┌────┴────┐
        │          │
     Valid    Invalid
        │          │
        │      Show errors
        │          │
        └────┬─────┘
             │
             ▼
        HOME SCREEN
        (Account created!)
```

---

## 2. Email Signup Flow (Detailed)

```
┌──────────────────────────────────┐
│  EMAIL SIGNUP SCREEN             │
│  - Full Name                     │
│  - Email                         │
│  - Username                      │
│  - Password                      │
│  - Confirm Password              │
│  - Terms Checkbox                │
└───────────────┬──────────────────┘
                │
                ▼
        ┌───────────────┐
        │ VALIDATE FORM │
        └───────┬───────┘
                │
        ┌───────┴────────┐
        │                │
      Valid          Invalid
        │                │
        ▼                ▼
  NEXT STEP      SHOW ERRORS
                 (Red validation msgs)
        │
        ▼
┌─────────────────────────────────┐
│ CALL AuthService.signUpWithEmail│
└─────────────┬───────────────────┘
              │
        ┌─────┴─────┐
        │           │
      Success    Error
        │           │
        ▼           ▼
    ┌──────┐   SHOW ERROR
    │ SAVE │   (Toast/Dialog)
    │USER  │   │
    └──┬───┘   │
       │       │
       ▼       │
  NAVIGATE TO  │
  PROFILE      │
  SETUP        │
       │       │
       └───┬───┘
           │
           ▼
      RETRY / BACK
```

---

## 3. Phone Signup Flow with OTP (Detailed)

```
┌──────────────────────────────────┐
│  PHONE SIGNUP SCREEN             │
│  - Full Name                     │
│  - Email (optional)              │
│  - Phone Number                  │
│  - Username                      │
│  - Password                      │
│  - Confirm Password              │
└───────────────┬──────────────────┘
                │
                ▼
        ┌───────────────┐
        │ VALIDATE FORM │
        └───────┬───────┘
                │
        ┌───────┴────────┐
        │                │
      Valid          Invalid
        │                │
        ▼                ▼
 SEND OTP          SHOW ERRORS
        │
        ▼
┌──────────────────────────┐
│ INITIATE OTP FLOW        │
│ POST to /auth/signup/phone
└──────────────┬───────────┘
               │
        ┌──────┴──────┐
        │             │
      Success    Error
        │             │
        ▼             ▼
   ┌────────────┐  SHOW ERROR
   │ SHOW OTP   │  (Cannot send OTP)
   │ VERIFICATION
   │ MODAL      │
   └────────┬───┘
            │
            ▼
   ┌─────────────────────┐
   │ USER ENTERS OTP     │
   │ (4 digit code)      │
   │ [_] [_] [_] [_]     │
   │ Timer: 05:00        │
   └────────┬────────────┘
            │
        ┌───┴────┐
        │        │
     VERIFY   RESEND
     (Submit) (Click)
        │        │
        ▼        ▼
   ┌──────┐  ┌─────────┐
   │POST  │  │Check:   │
   │OTP   │  │Attempts < 3?
   │      │  └────┬────┘
   └──┬───┘       │
      │    ┌──────┴──────┐
      │    │             │
      │   Yes            No
      │    │             │
      │    ▼             ▼
      │  RESEND      MAX ATTEMPTS
      │  OTP         REACHED
      │    │         (Disable button)
      │    │
      ├────┘
      │
   ┌──┴──────────┐
   │             │
 Valid       Invalid
   │             │
   ▼             ▼
SAVE      SHOW ERROR
USER      "Invalid OTP"
   │
   ▼
NAVIGATE TO
PROFILE SETUP
```

---

## 4. Profile Setup Flow

```
┌──────────────────────────────────┐
│  PROFILE SETUP SCREEN            │
│                                  │
│  Step 1: Health Metrics          │
│  - Age (dropdown)                │
│  - Cycle Length (dropdown)       │
│  - Period Length (dropdown)      │
│  - Last Period Date (date picker)│
│                                  │
│  Step 2: Preferences             │
│  - TTC History (dropdown)        │
│  - Faith Preference (dropdown)   │
│  - Language (dropdown)           │
│  - Audio Guidance (toggle)       │
│                                  │
│  Step 3: Terms                   │
│  - Terms Checkbox                │
│                                  │
│  [Submit Profile]                │
└───────────────┬──────────────────┘
                │
                ▼
        ┌──────────────────┐
        │  VALIDATE ALL    │
        │  REQUIRED FIELDS │
        └────────┬─────────┘
                 │
         ┌───────┴───────┐
         │               │
       Valid         Invalid
         │               │
         ▼               ▼
    NEXT STEP      SHOW ERRORS
         │         (Highlight fields)
         │               │
         │               └──┬──┘
         │                  │
         ▼                  │
    ┌─────────────────┐     │
    │CHECK TERMS      │     │
    │ACCEPTED?        │     │
    └────────┬────────┘     │
             │              │
         ┌───┴───┐           │
         │       │           │
        Yes      No          │
         │       │           │
         ▼       ▼           │
       NEXT  SHOW ERROR      │
             (Must accept)   │
         │       │           │
         └───┬───┘           │
             │               │
             ▼               │
    ┌───────────────────┐    │
    │ CALL              │    │
    │ updateUserProfile │    │
    └─────────┬─────────┘    │
              │              │
        ┌─────┴─────┐        │
        │           │        │
      Success   Error        │
        │           │        │
        ▼           ▼        │
      SAVE      SHOW ERROR   │
      PROFILE   (Toast)      │
      DATA      │            │
        │       │            │
        │       └────┬───────┘
        │            │
        ▼       RETRY
      SHOW
    SUCCESS
    MESSAGE
        │
        ▼
    NAVIGATE
    TO HOME
    SCREEN
```

---

## 5. State Management Diagram

```
┌─────────────────────────────────────┐
│         PROVIDER SETUP              │
│                                     │
│  MultiProvider                      │
│  ├── AuthService                    │
│  │   ├── _currentUser               │
│  │   ├── _authStateController       │
│  │   └── _prefsKey                  │
│  │                                  │
│  └── LocalizationProvider           │
│      ├── selectedLanguageCode       │
│      └── supportedLanguages         │
└─────────────────────────────────────┘

                │
                ▼

    ┌───────────────────────┐
    │   DATA FLOW           │
    │                       │
    │  Screen Input ──────┐ │
    │                   │ │ │
    │                   ▼ ▼ │
    │            AuthService │
    │               Methods  │
    │                   │    │
    │      ┌────────────┼────┴──────┐
    │      │            │           │
    │      ▼            ▼           ▼
    │   LocalSave  NotifyListeners  Emit Stream
    │      │            │           │
    │      └────┬───────┴───────────┘
    │           │
    │           ▼
    │      UI Updates
    └───────────────────────┘

                │
                ▼

    ┌─────────────────────┐
    │  DATA PERSISTENCE   │
    │  (SharedPreferences)│
    │                     │
    │  Keys:              │
    │  - currentUser      │
    │  - userProfile      │
    │  - selectedLanguage │
    │  - authToken        │
    └─────────────────────┘
```

---

## 6. Error Handling Flow

```
┌─────────────────┐
│  USER ACTION    │
│  (Submit Form)  │
└────────┬────────┘
         │
         ▼
    ┌──────────────┐
    │ API REQUEST  │
    │ MADE         │
    └────┬─────────┘
         │
    ┌────┴──────────────────────────┐
    │                               │
    ▼                               ▼
┌──────────────┐           ┌─────────────────┐
│   SUCCESS    │           │   ERROR         │
│ (2xx Status) │           │ (4xx/5xx)       │
└──────┬───────┘           └────────┬────────┘
       │                            │
       ▼                      ┌─────┴──────────────┐
    ┌─────────────┐           │                    │
    │ PARSE DATA  │           ▼                    ▼
    │ SAVE TO     │    ┌──────────────┐      ┌──────────────┐
    │ SHARED      │    │ NETWORK      │      │ VALIDATION   │
    │ PREFERENCES │    │ ERROR        │      │ ERROR        │
    │ UPDATE USER │    └──────┬───────┘      └──────┬───────┘
    │             │           │                     │
    │ NOTIFY      │           ▼                     ▼
    │ LISTENERS   │    ┌──────────────┐      ┌──────────────┐
    └─────┬───────┘    │ SHOW TOAST   │      │ SHOW INLINE  │
          │            │ WITH MESSAGE │      │ VALIDATION   │
          │            │ "Network     │      │ ERROR MSGS   │
          │            │  error"      │      └──────┬───────┘
          │            │ [RETRY BTN]  │             │
          │            └──────┬───────┘             │
          │                   │                     │
          ├───────────────────┴─────────────────────┘
          │
          ▼
    ┌────────────────────┐
    │ TRIGGER NEXT STEP  │
    │ (Navigate, etc)    │
    └────────────────────┘
```

---

## 7. OTP Lifecycle

```
TIME: 0s
    │
    ├─ OTP Generated
    │  ├─ Random 4 digits
    │  └─ Send via SMS
    │
    ├─ SMS Sent
    │  └─ User receives code
    │
TIME: Start Wait
    │
    ├─ User enters OTP
    │  └─ [_] [_] [_] [_]
    │
TIME: 0-300s (5 minutes)
    │
    ├─ Timer Running
    │  ├─ Display countdown
    │  └─ Every second: -1
    │
    ├─ User can:
    │  ├─ Submit OTP
    │  │  └─ Success/Fail
    │  └─ Resend OTP
    │     ├─ Check: attempts < 3?
    │     └─ If yes: 
    │        ├─ Generate new OTP
    │        ├─ Send SMS
    │        └─ Reset timer to 5min
    │
TIME: 300s (5 minutes)
    │
    ├─ OTP Expires
    │  ├─ Timer shows 00:00
    │  ├─ Disable submit
    │  └─ "OTP Expired" message
    │
    └─ User must resend
       └─ If attempts remaining:
          └─ Request new OTP

RESEND FLOW:
    Attempt 1 (✓)
    Attempt 2 (✓)
    Attempt 3 (✓)
    Attempt 4 (✗) → "Maximum attempts reached"
                    → Button disabled
                    → Message shown
```

---

## 8. Navigation State Tree

```
Application Root
│
├── Unauthenticated Flow
│   ├── Splash Screen
│   │   ├── Delay 2 seconds
│   │   └── Check user status
│   │
│   ├── Welcome Screen
│   │   ├── Create Account Button
│   │   │   └── → Language Selection
│   │   │       └── → Account Type Selection
│   │   │           ├── Email Path
│   │   │           │   └── → Email Signup Screen
│   │   │           │       └── → Profile Setup
│   │   │           │           └── → [Home] (Authenticated)
│   │   │           │
│   │   │           └── Phone Path
│   │   │               └── → Phone Signup Screen
│   │   │                   └── → OTP Modal
│   │   │                       └── → Profile Setup
│   │   │                           └── → [Home] (Authenticated)
│   │   │
│   │   └── Log In Button
│   │       └── → Login Screen
│   │           └── [Home] (Authenticated)
│   │
│   └── Login Screen
│       └── → [Home] (Authenticated)
│
└── Authenticated Flow
    └── Home Screen
        ├── Tracking
        ├── Calendar
        ├── Community
        ├── Education
        ├── Profile
        └── Settings
```

---

## 9. Data Flow in Email Signup

```
┌────────────────────────────────────────────────────┐
│              EMAIL SIGNUP SCREEN                    │
│  User enters:                                       │
│  - fullName = "John Doe"                           │
│  - email = "john@example.com"                      │
│  - username = "johndoe"                            │
│  - password = "Password123"                        │
│  - confirmPassword = "Password123"                 │
└──────────────────┬─────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  VALIDATION          │
        │  - Email format ✓    │
        │  - Password length ✓ │
        │  - Match confirm ✓   │
        │  - Terms agreed ✓    │
        └────────┬─────────────┘
                 │
                 ▼
    ┌────────────────────────────────┐
    │ AuthService.signUpWithEmail()  │
    └──────────────┬─────────────────┘
                   │
                   ▼
    ┌────────────────────────────────┐
    │ Call API:                       │
    │ POST /auth/signup/email         │
    │ {                               │
    │   "email": "john@example.com",  │
    │   "password": "Password123",    │
    │   "firstName": "John",          │
    │   "lastName": "Doe",            │
    │   "username": "johndoe"         │
    │ }                               │
    └──────────────┬─────────────────┘
                   │
                   ▼
    ┌────────────────────────────────┐
    │ API Response (Status 201)       │
    │ {                               │
    │   "id": "user_123",             │
    │   "email": "john@example.com",  │
    │   "firstName": "John",          │
    │   "lastName": "Doe",            │
    │   "username": "johndoe",        │
    │   "emailVerified": false,       │
    │   "createdAt": "2024-01-20..."  │
    │ }                               │
    └──────────────┬─────────────────┘
                   │
        ┌──────────┴────────────┐
        │                       │
        ▼                       ▼
    ┌─────────────┐      ┌──────────────────────┐
    │ PARSE JSON  │      │ SAVE TO              │
    │ CREATE USER │      │ SHARED PREFERENCES   │
    │ OBJECT      │      │                      │
    └──────┬──────┘      │ Key: "currentUser"   │
           │             │ Value: JSON string   │
           └─────────┬───┘
                     │
                     ▼
        ┌────────────────────────────────┐
        │ Update AuthService State       │
        │ _currentUser = userObject      │
        │ notifyListeners()              │
        └──────────┬─────────────────────┘
                   │
                   ▼
        ┌────────────────────────────────┐
        │ Navigate to:                    │
        │ /profile-setup                  │
        └────────────────────────────────┘
```

---

## 10. OTP Request & Verification Sequence

```
USER                          APP                    BACKEND
 │                            │                        │
 │ Submit Phone #             │                        │
 ├────────────────────────────>                        │
 │                            │                        │
 │                            │ POST /signup/phone     │
 │                            ├───────────────────────>│
 │                            │                        │
 │                            │ Generate OTP: "1234"  │
 │                            │ Save mapping          │
 │                            │ {phone: otp, time}    │
 │                            │                        │
 │                            │ Send SMS to +234...   │
 │                            │ "Your code: 1234"     │
 │                            │                        │
 │                            │ Return 200 OK         │
 │                            |<───────────────────────│
 │                            │                        │
 │ Receives SMS               │                        │
 │ "Your code: 1234"          │                        │
 │                            │                        │
 │ Enters OTP: 1234           │                        │
 ├────────────────────────────>                        │
 │                            │                        │
 │                            │ POST /verify-otp      │
 │                            │ {phone, otp}          │
 │                            ├───────────────────────>│
 │                            │                        │
 │                            │ Lookup: {phone: otp}  │
 │                            │ Check time < 5min     │
 │                            │ Match? 1234 == 1234   │
 │                            │ ✓ VALID              │
 │                            │                        │
 │                            │ Create User Account   │
 │                            │ Set emailVerified=true│
 │                            │ Clear OTP record      │
 │                            │                        │
 │                            │ Return 200 + User     │
 │                            |<───────────────────────│
 │                            │                        │
 │                            │ Save User to Prefs    │
 │                            │ Update _currentUser   │
 │                            │ notifyListeners()     │
 │                            │                        │
 │ "Account Created!" ✓       │                        │
 |<────────────────────────────                        │
 │                            │                        │
 │ Navigate to Profile Setup  │                        │
 ├────────────────────────────>                        │
 │                            │                        │
```

---

## 11. Error Scenarios

```
SCENARIO 1: Duplicate Email
─────────────────────────────
User enters: email = "existing@example.com"
     │
     ▼
API Check: Email exists?
     │
    YES
     │
     ▼
Return 409 Conflict
"Email already registered"
     │
     ▼
Show error in TextField
"This email is already in use"
     │
     ▼
User can:
 ├─ Enter different email
 └─ Click "Forgot Password?"

SCENARIO 2: OTP Timeout
──────────────────────
OTP sent at 12:00
User enters at 12:06 (6 minutes)
     │
     ▼
Check: (now - sent_time) > 5min?
     │
    YES (360s > 300s)
     │
     ▼
Show: "OTP Expired"
     │
     ▼
Display "Resend OTP" button
     │
     ▼
User clicks resend
(if attempts < 3)
     │
     ▼
New OTP sent
Reset timer

SCENARIO 3: Max Resend Attempts
────────────────────────────────
User:
 Resend 1 ✓
 Resend 2 ✓
 Resend 3 ✓
 Attempt Resend 4
     │
     ▼
Check: resend_count < 3?
     │
    NO
     │
     ▼
Show: "Maximum resend attempts"
     │
     ▼
Disable resend button
     │
     ▼
Option: Contact support
```

---

## Legend

```
┌──┐  Box = Screen/Component
│  │
└──┘

──────>  Arrow = Navigation/Data flow

✓ ✗     Check/Cross = Status
  
if      Conditional logic

Time    Duration/Sequence
```

---

*Last Updated: January 2025*
*For questions or clarifications, refer to ACCOUNT_WORKFLOW_GUIDE.md and ACCOUNT_WORKFLOW_IMPLEMENTATION.md*
