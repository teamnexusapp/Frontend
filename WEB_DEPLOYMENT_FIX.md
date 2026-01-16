# Flutter Web Deployment Fix for Render

## Problem Summary
The GitHub workflow succeeds but Render deployment fails at runtime with an uncaught error in `main.dart.js`. This is typically caused by:

1. **SharedPreferences initialization issues on web**
2. **Firebase initialization timing problems**
3. **Async initialization not awaiting properly**
4. **Missing error handling for platform-specific features**

## Changes Made

### 1. **main.dart - Added Robust Error Handling**

#### Firebase Initialization
```dart
Future<void> _initializeFirebase() async {
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(...),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Firebase timeout'),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('Firebase error: $e');
    // App continues without Firebase - uses fallback auth
  }
}
```

**Why**: Firebase SDK loading can fail on some networks. The timeout and try-catch prevent the entire app from crashing.

#### SharedPreferences Initialization
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();

  String saved = 'system';
  try {
    final prefs = await SharedPreferences.getInstance();
    saved = prefs.getString('theme_mode') ?? 'system';
  } catch (e) {
    debugPrint('SharedPreferences error: $e');
  }

  runApp(MyApp(initialTheme: saved));
}
```

**Why**: SharedPreferences on web uses IndexedDB which can fail if not properly initialized or if quota is exceeded.

### 2. **render.yaml - Optimized Build Configuration**

Added:
- **Skia Disabling**: `--dart-define=FLUTTER_WEB_USE_SKIA=false`
  - Skia can cause memory issues in constrained environments
  
- **CORS Headers**: Allows cross-origin requests from your API
  
- **Cache Headers**: Reduces bandwidth and speeds up repeat visits
  - index.html: 60s (allows quick updates)
  - Other files: 3600s (1 hour)

### 3. **Async Error Handling in setThemeMode**

```dart
Future<void> _setThemeMode(ThemeMode tm) async {
  setState(() => _themeMode = tm);
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', key);
  } catch (e) {
    debugPrint('Error saving theme: $e');
  }
}
```

**Why**: Setting theme should not crash the app if storage fails.

## Testing Locally Before Deploying

```bash
# Build web locally
flutter clean
flutter pub get
flutter build web --release

# Test the build locally
cd build/web
python3 -m http.server 8000
# Visit http://localhost:8000
```

## Render Deployment Steps

1. **Push changes to GitHub**
   ```bash
   git add .
   git commit -m "Fix: Add robust error handling for web deployment"
   git push origin main
   ```

2. **Render will auto-deploy** (if autoDeploy: true in render.yaml)

3. **Monitor deployment**
   - Go to https://dashboard.render.com
   - Select "fertipath" service
   - Check "Build Logs" for any errors
   - Check "Runtime Logs" after deployment

## Debugging if Issues Persist

### Check Browser Console
1. Deploy to Render
2. Open the app
3. Press F12 → Console tab
4. Look for exact error messages
5. Search for line numbers in `main.dart.js`

### Common Issues & Fixes

**Issue**: "SharedPreferences not initialized"
- **Fix**: Already handled in latest code

**Issue**: "Firebase SDK load failed"
- **Fix**: App now uses fallback auth, check backend connectivity

**Issue**: "CORS errors on API calls"
- **Fix**: Backend must have CORS headers, or use CORS proxy

**Issue**: "Memory exceeded during build"
- **Fix**: The Skia disable should help. Contact Render support for higher build limits.

### Enable Debug Logging on Web

Add to web/index.html before `flutter_bootstrap.js`:
```html
<script>
  console.log('Flutter app starting...');
  window.flutterDebug = true;
</script>
```

## Next Steps

1. **Test locally**: `flutter build web --release && cd build/web && python3 -m http.server`
2. **Push to GitHub**: Changes are already made in main.dart and render.yaml
3. **Monitor Render deployment**: Check logs in Render dashboard
4. **Verify browser console**: Ensure no new errors appear

## Prevention for Future Issues

- Always handle async operations that can fail
- Use try-catch blocks for platform-specific features
- Test Flutter web builds locally before deployment
- Monitor browser console errors in production
- Use Flutter DevTools: `flutter pub global run devtools`

---

**Status**: ✅ Ready to deploy
**Last Updated**: January 16, 2026
