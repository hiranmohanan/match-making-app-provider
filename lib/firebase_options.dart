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
    apiKey: 'AIzaSyDFjKmHWdohv2TeowqRBhdVSv1wK0_ywQc',
    appId: '1:679716517261:web:5d8e029665a0594a8e39c4',
    messagingSenderId: '679716517261',
    projectId: 'match-making-app-664b9',
    authDomain: 'match-making-app-664b9.firebaseapp.com',
    storageBucket: 'match-making-app-664b9.appspot.com',
    measurementId: 'G-CEHB7CYR6Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2waXAG7boEDFV5FbQJdW5a8YGV7dbW0g',
    appId: '1:679716517261:android:c5902b2ef9d59f968e39c4',
    messagingSenderId: '679716517261',
    projectId: 'match-making-app-664b9',
    storageBucket: 'match-making-app-664b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0J4Pz6gq6hGLkYB75I_TpIIpkrt9X3yU',
    appId: '1:679716517261:ios:2391c894d3a6914a8e39c4',
    messagingSenderId: '679716517261',
    projectId: 'match-making-app-664b9',
    storageBucket: 'match-making-app-664b9.appspot.com',
    iosBundleId: 'com.example.matchMakingTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0J4Pz6gq6hGLkYB75I_TpIIpkrt9X3yU',
    appId: '1:679716517261:ios:4736b82b7e631db58e39c4',
    messagingSenderId: '679716517261',
    projectId: 'match-making-app-664b9',
    storageBucket: 'match-making-app-664b9.appspot.com',
    iosBundleId: 'com.example.matchMakingTest.RunnerTests',
  );
}
