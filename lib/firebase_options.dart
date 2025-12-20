import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Placeholder Firebase web configuration.
/// TODO: Replace with real values from your Firebase project.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    // For Android/iOS/macOS/Windows/Linux, the native files/plists handle config.
    // Returning web only; non-web platforms can use Firebase.initializeApp() without options.
    throw UnsupportedError('DefaultFirebaseOptions.currentPlatform is only used for web here.');
  }

  // Web FirebaseOptions
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'TODO_API_KEY',
    appId: 'TODO_APP_ID',
    projectId: 'TODO_PROJECT_ID',
    authDomain: 'TODO_AUTH_DOMAIN',
    storageBucket: 'TODO_STORAGE_BUCKET',
    messagingSenderId: 'TODO_MESSAGING_SENDER_ID',
    measurementId: 'TODO_MEASUREMENT_ID',
  );
}
