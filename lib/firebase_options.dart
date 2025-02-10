import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAfBvHrJh4zT6pFFuK4FeSlHMSJsrHJvz4",
      authDomain: "schedulerapp-992c3.firebaseapp.com",
      projectId: "schedulerapp-992c3",
      storageBucket: "schedulerapp-992c3.firebasestorage.app",
      messagingSenderId: "276515975099",
      appId: "1:276515975099:web:7f04a1b9a194d409e99e9e");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfBvHrJh4zT6pFFuK4FeSlHMSJsrHJvz4',
    appId: '1:276515975099:android:aab37ff9c8bc22abe99e9e',
    messagingSenderId: '276515975099',
    projectId: 'schedulerapp-992c3',
    storageBucket: 'schedulerapp-992c3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfBvHrJh4zT6pFFuK4FeSlHMSJsrHJvz4',
    appId: '1:276515975099:android:aab37ff9c8bc22abe99e9e',
    messagingSenderId: '276515975099',
    projectId: 'schedulerapp-992c3',
    storageBucket: 'schedulerapp-992c3.firebasestorage.app',
    iosBundleId: 'com.example.schedullerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfBvHrJh4zT6pFFuK4FeSlHMSJsrHJvz4',
    appId: '1:276515975099:android:aab37ff9c8bc22abe99e9e',
    messagingSenderId: '276515975099',
    projectId: 'schedulerapp-992c3',
    storageBucket: 'schedulerapp-992c3.firebasestorage.app',
    iosBundleId: 'com.example.schedullerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyAfBvHrJh4zT6pFFuK4FeSlHMSJsrHJvz4",
    authDomain: "schedulerapp-992c3.firebaseapp.com",
    projectId: "schedulerapp-992c3",
    storageBucket: "schedulerapp-992c3.firebasestorage.app",
    messagingSenderId: "276515975099",
    appId: "1:276515975099:web:3ec0da621654954be99e9e",
  );
}
