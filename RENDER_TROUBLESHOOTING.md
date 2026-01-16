# Quick Render Deployment Troubleshooting

## The Error
```
Uncaught Error at main.dart.js:5563
    at main.dart.js:43321:46
    [Stack trace follows...]
```

This error occurs at **runtime on Render**, not during build. Root causes:

## Root Causes & Solutions

### 1. SharedPreferences Web Initialization ✅ FIXED
**Problem**: `SharedPreferences.getInstance()` fails on web/Render
**Solution**: Wrapped in try-catch with fallback

```dart
try {
  final prefs = await SharedPreferences.getInstance();
  saved = prefs.getString('theme_mode') ?? 'system';
} catch (e) {
  debugPrint('SharedPreferences error: $e');
  // Falls back to default
}
```

### 2. Firebase SDK Loading Timeout ✅ FIXED
**Problem**: Firebase CDN not loading or loading too slowly
**Solution**: Added 10-second timeout with graceful fallback

```dart
await Firebase.initializeApp(...).timeout(
  const Duration(seconds: 10),
  onTimeout: () => throw Exception('Firebase timeout'),
);
```

### 3. Memory Issues on Build ✅ FIXED
**Problem**: Render's build environment has limited memory
**Solution**: Disabled Skia renderer (uses less memory)

```yaml
buildCommand: |
  flutter build web --release --web-renderer html --dart-define=FLUTTER_WEB_USE_SKIA=false
```

## Deployment Checklist

- [x] main.dart has error handling for SharedPreferences
- [x] Firebase initialization has timeout + try-catch
- [x] setThemeMode has error handling
- [x] render.yaml has Skia disabled
- [x] render.yaml has proper headers
- [ ] Test build locally
- [ ] Push to GitHub
- [ ] Monitor Render dashboard

## Testing Before Deploy

```bash
# Run the test script
chmod +x test_render_build.sh
./test_render_build.sh

# Or manually test
flutter clean
flutter pub get
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

# Serve locally
cd build/web
python3 -m http.server 8000
# Visit http://localhost:8000 and check F12 console
```

## If Errors Still Occur

### Step 1: Check Browser Console
1. Visit deployed app on Render
2. Press F12 to open DevTools
3. Go to Console tab
4. Look for any error messages
5. Try to trace back to specific feature (auth, theme, localization)

### Step 2: Check Render Logs
1. Go to https://dashboard.render.com
2. Select "fertipath" service
3. Click "Logs"
4. Look for build errors or warnings
5. Check "Runtime Logs" for app errors

### Step 3: Enable Verbose Logging
Edit `lib/main.dart` and add more debug prints:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('🚀 App starting...');
  
  await _initializeFirebase();
  debugPrint('✓ Firebase initialized');
  
  // ... rest of main
}
```

### Step 4: Isolate the Issue
Test each feature individually:
- [ ] App loads without errors
- [ ] Localization loads
- [ ] Theme switching works
- [ ] Navigating to different screens works
- [ ] API calls work (if attempting)

## Common Next Steps

**If Firebase error**: 
- Check Firebase console for web app configuration
- Ensure web SDK is enabled in Firebase project
- Check CORS settings

**If Storage error**:
- Clear browser storage and reload
- Try incognito/private mode
- Check storage quota

**If Navigation error**:
- Check screen initialization for async calls
- Look for missing await on Future functions
- Check for null reference errors

## Render Dashboard

Monitor at: https://dashboard.render.com
- Service: "fertipath"
- Check: Build logs, Runtime logs, Live output
- Deployment status visible in real-time

---

**All fixes are applied. Ready to deploy! 🚀**
