# Backend Connection Troubleshooting Guide

## Issue: "Backend encountered a problem, try later or contact support"

This error (HTTP 500) occurs when the backend server is unavailable or experiencing issues.

### Common Causes

1. **Render Free Tier Sleep Mode** (Most Common)
   - Render's free tier puts services to sleep after 15 minutes of inactivity
   - The server takes 30-50 seconds to wake up when receiving the first request
   - This causes initial requests to timeout or fail with 500 errors

2. **Backend Server Issues**
   - Database connection problems
   - Backend code errors
   - Server overload

3. **Network Issues**
   - Poor internet connection
   - Firewall blocking requests
   - DNS resolution problems

### Solutions Implemented

#### 1. **Automatic Retry Logic**
- API requests now automatically retry up to 2 times on 500 errors
- 5-second delay between retries to allow server to wake up
- Increased timeout from 30s to 45s for initial requests

#### 2. **Better Error Messages**
- Users now see: "The backend server is temporarily unavailable. This may be because the server is starting up (this can take up to 30 seconds). Please wait a moment and try again."
- Instead of generic "contact support" message

#### 3. **Health Check Service**
- New `HealthCheckService` to test backend connectivity
- Can be used to wake up the backend before user actions
- Usage:
  ```dart
  import 'package:nexus_fertility_app/services/health_check_service.dart';
  
  // Check if backend is healthy
  bool isHealthy = await HealthCheckService.checkBackendHealth();
  
  // Wake up backend (waits up to 30 seconds)
  bool isAwake = await HealthCheckService.wakeUpBackend();
  ```

### How to Use

#### For Users:
1. If you see the error, **wait 30 seconds** and try again
2. The backend is likely just waking up from sleep
3. Subsequent requests will be fast once the server is awake

#### For Developers:

**Option 1: Add Loading State with Wake-Up**
```dart
Future<void> _handleSignup() async {
  setState(() => _isLoading = true);
  
  // Wake up backend first (optional but recommended)
  await HealthCheckService.wakeUpBackend();
  
  // Then proceed with signup
  await authService.signUpWithEmail(...);
}
```

**Option 2: Show Backend Status**
```dart
Future<void> _checkBackendStatus() async {
  final isHealthy = await HealthCheckService.checkBackendHealth();
  
  if (!isHealthy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Backend server is starting up, please wait...'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
```

### Testing the Backend Manually

You can test if the backend is up using curl:

```bash
curl -v https://fertility-fastapi.onrender.com/
```

Or check specific endpoints:
```bash
# Health check (if available)
curl https://fertility-fastapi.onrender.com/health

# Auth endpoints
curl https://fertility-fastapi.onrender.com/auth/
```

### Backend URL
- Production: `https://fertility-fastapi.onrender.com`
- Hosted on: Render (Free Tier)

### Files Modified
1. `/lib/services/api_service.dart`
   - Added retry logic to `sendOtp()` and `login()` methods
   - Increased timeout from 30s to 45s
   - Added retry counter parameter

2. `/lib/services/auth_service.dart`
   - Improved error messages for 500 errors
   - Added timeout exception handling
   - Made error messages more user-friendly

3. `/lib/services/health_check_service.dart` (NEW)
   - Health check functionality
   - Backend wake-up utility

### Recommendations

1. **For Production**: Consider upgrading to a paid Render plan to avoid sleep mode
2. **For Development**: Keep the backend warm by pinging it every 10 minutes
3. **For Users**: Add a loading spinner that says "Starting up server..." for first-time users

### Next Steps

If issues persist after these changes:
1. Check backend logs on Render dashboard
2. Verify backend is deployed and running
3. Test backend endpoints manually
4. Check for backend code errors
5. Contact backend team if server repeatedly crashes
