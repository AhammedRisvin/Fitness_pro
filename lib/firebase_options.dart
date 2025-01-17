// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0R4AZWK9klxUzGIakov-qG3ywBXRZgco',
    appId: '1:569536696047:web:50871a16ef8f1046e5951a',
    messagingSenderId: '569536696047',
    projectId: 'olympic-3c6e3',
    authDomain: 'olympic-3c6e3.firebaseapp.com',
    storageBucket: 'olympic-3c6e3.appspot.com',
    measurementId: 'G-ZE6KE6TW13',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0AU0bGd4M-Pic_pDy8YZmXCFb_mGAjQE',
    appId: '1:569536696047:android:3e7dab4254463d4de5951a',
    messagingSenderId: '569536696047',
    projectId: 'olympic-3c6e3',
    storageBucket: 'olympic-3c6e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAShjzNenMevTAcgVFZl85ZVZj4jsctUwU',
    appId: '1:569536696047:ios:e18f829784187ce5e5951a',
    messagingSenderId: '569536696047',
    projectId: 'olympic-3c6e3',
    storageBucket: 'olympic-3c6e3.appspot.com',
    iosBundleId: 'com.olympic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAShjzNenMevTAcgVFZl85ZVZj4jsctUwU',
    appId: '1:569536696047:ios:9e1a84b6c07dc550e5951a',
    messagingSenderId: '569536696047',
    projectId: 'olympic-3c6e3',
    storageBucket: 'olympic-3c6e3.appspot.com',
    iosBundleId: 'com.olympic.RunnerTests',
  );
}
