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
    apiKey: 'AIzaSyBHuNCS40VoAkSxn92sE5FLgEIgV9FmF5c',
    appId: '1:305487500641:web:1aa5d66aa389838bfda120',
    messagingSenderId: '305487500641',
    projectId: 'match-making-app-bbfd5',
    authDomain: 'match-making-app-bbfd5.firebaseapp.com',
    storageBucket: 'match-making-app-bbfd5.appspot.com',
    measurementId: 'G-GJ6X3FWVVP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaOVIx8FrU-tRuztJJO2gZF1kPKVoN-X0',
    appId: '1:305487500641:android:7b786b5f52a01c2ffda120',
    messagingSenderId: '305487500641',
    projectId: 'match-making-app-bbfd5',
    storageBucket: 'match-making-app-bbfd5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkPOgjk78akNvq4zM6Ibf3oEgSm1wrFzQ',
    appId: '1:305487500641:ios:76f47318f941d93afda120',
    messagingSenderId: '305487500641',
    projectId: 'match-making-app-bbfd5',
    storageBucket: 'match-making-app-bbfd5.appspot.com',
    iosBundleId: 'com.example.matchMakingTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkPOgjk78akNvq4zM6Ibf3oEgSm1wrFzQ',
    appId: '1:305487500641:ios:44cc9e246fd03f51fda120',
    messagingSenderId: '305487500641',
    projectId: 'match-making-app-bbfd5',
    storageBucket: 'match-making-app-bbfd5.appspot.com',
    iosBundleId: 'com.example.matchMakingTest.RunnerTests',
  );
}
