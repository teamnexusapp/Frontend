// DefaultFirebaseOptions are not configured for this project.
// Configure Firebase by running:
// flutterfire configure

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: 'AIzaSyDummyKeyForDevelopmentOnly',
      appId: '1:1234567890:android:abcd1234',
      messagingSenderId: '1234567890',
      projectId: 'nexus-fertility-dev',
      storageBucket: 'nexus-fertility-dev.appspot.com',
    );
  }
}
