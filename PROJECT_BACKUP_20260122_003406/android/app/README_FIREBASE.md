# Firebase Setup Instructions

## Required: Add google-services.json

**⚠️ IMPORTANT**: You must add your `google-services.json` file to this directory before building the app.

### Steps:

1. **Go to Firebase Console**: https://console.firebase.google.com/

2. **Create or select your project**

3. **Add an Android app**:
   - Click on the Android icon or "Add app"
   - Enter package name: `com.example.nexus_fertility_app`
   - Register the app

4. **Download google-services.json**:
   - After registering, download the `google-services.json` file
   - Place it in: `/workspaces/Frontend/android/app/google-services.json`

5. **Enable Firebase Authentication**:
   - In Firebase Console, go to Authentication
   - Click "Get Started"
   - Enable your desired sign-in methods (Email/Password, Google, etc.)

6. **Run Flutter pub get**:
   ```bash
   flutter pub get
   ```

7. **Build and run your app**:
   ```bash
   flutter run
   ```

## File Location
```
android/
  app/
    google-services.json  ← Place your file here
    build.gradle.kts
    ...
```

## Security Note
- **Never commit** `google-services.json` to version control if it contains sensitive data
- Add it to `.gitignore` if needed
- For teams, use environment-specific configurations

## Verification
The app has been configured with:
- Firebase Core (^2.24.2)
- Firebase Auth (^4.16.0)
- Google Services plugin (4.4.0)

Once you add the file, you're ready to implement Firebase Authentication in your Flutter app!
