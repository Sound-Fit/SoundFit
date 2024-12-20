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
    apiKey: 'AIzaSyBoH0mLFXjSYOHdW1llumMClG9gq-ohUV4',
    appId: '1:1065763588085:web:febb9b2ace9ff20f8c42bc',
    messagingSenderId: '1065763588085',
    projectId: 'soundfit-bfedd',
    authDomain: 'soundfit-bfedd.firebaseapp.com',
    storageBucket: 'soundfit-bfedd.firebasestorage.app',
    measurementId: 'G-EP57NVS804',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1mBFvb4DUDkV-fEdJmLNXuvQKShfeME8',
    appId: '1:1065763588085:android:9d33367908a3a1e88c42bc',
    messagingSenderId: '1065763588085',
    projectId: 'soundfit-bfedd',
    storageBucket: 'soundfit-bfedd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAusKZhLWoua5OR57CT3wISOccUp5lF-A',
    appId: '1:1065763588085:ios:aab675a5ffa4168d8c42bc',
    messagingSenderId: '1065763588085',
    projectId: 'soundfit-bfedd',
    storageBucket: 'soundfit-bfedd.firebasestorage.app',
    iosBundleId: 'com.example.soundfit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAusKZhLWoua5OR57CT3wISOccUp5lF-A',
    appId: '1:1065763588085:ios:aab675a5ffa4168d8c42bc',
    messagingSenderId: '1065763588085',
    projectId: 'soundfit-bfedd',
    storageBucket: 'soundfit-bfedd.firebasestorage.app',
    iosBundleId: 'com.example.soundfit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoH0mLFXjSYOHdW1llumMClG9gq-ohUV4',
    appId: '1:1065763588085:web:df9d66a78b8e29168c42bc',
    messagingSenderId: '1065763588085',
    projectId: 'soundfit-bfedd',
    authDomain: 'soundfit-bfedd.firebaseapp.com',
    storageBucket: 'soundfit-bfedd.firebasestorage.app',
    measurementId: 'G-L1D03GK80S',
  );
}
