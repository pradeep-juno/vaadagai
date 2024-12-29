// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAqWLx6ZwYxfy9QkgH7MmwLPWSRW4kqgFc',
    appId: '1:708167083575:web:38cbb5ce33f9ca129d41b2',
    messagingSenderId: '708167083575',
    projectId: 'vaadagai-64012',
    authDomain: 'vaadagai-64012.firebaseapp.com',
    storageBucket: 'vaadagai-64012.firebasestorage.app',
    measurementId: 'G-CXP1E2V0WF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOmStiq9S-oGurnXBJ6Q1kOYyG7BOETmk',
    appId: '1:708167083575:android:8e532901617da21d9d41b2',
    messagingSenderId: '708167083575',
    projectId: 'vaadagai-64012',
    storageBucket: 'vaadagai-64012.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCF3geLnnOlPGmaIOCj9KZVydv9q6huF8U',
    appId: '1:708167083575:ios:3f56ce41609e056c9d41b2',
    messagingSenderId: '708167083575',
    projectId: 'vaadagai-64012',
    storageBucket: 'vaadagai-64012.firebasestorage.app',
    iosBundleId: 'com.example.vaadagai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCF3geLnnOlPGmaIOCj9KZVydv9q6huF8U',
    appId: '1:708167083575:ios:3f56ce41609e056c9d41b2',
    messagingSenderId: '708167083575',
    projectId: 'vaadagai-64012',
    storageBucket: 'vaadagai-64012.firebasestorage.app',
    iosBundleId: 'com.example.vaadagai',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqWLx6ZwYxfy9QkgH7MmwLPWSRW4kqgFc',
    appId: '1:708167083575:web:fd1e626e19cdb5dc9d41b2',
    messagingSenderId: '708167083575',
    projectId: 'vaadagai-64012',
    authDomain: 'vaadagai-64012.firebaseapp.com',
    storageBucket: 'vaadagai-64012.firebasestorage.app',
    measurementId: 'G-XJJHWP3LVT',
  );
}