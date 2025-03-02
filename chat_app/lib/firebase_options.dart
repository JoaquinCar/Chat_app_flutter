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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB2REfrxwFykN-0QlNF-yAJhCSw0US64d8',
    appId: '1:1079301383389:web:f4cf11159892152b3f6734',
    messagingSenderId: '1079301383389',
    projectId: 'chatapp-3acae',
    authDomain: 'chatapp-3acae.firebaseapp.com',
    storageBucket: 'chatapp-3acae.firebasestorage.app',
    measurementId: 'G-RWR1L7K15C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ0V_ALqsEpf3MIHsbDR5VZvF7a-fjaCY',
    appId: '1:1079301383389:android:90f0264187c106443f6734',
    messagingSenderId: '1079301383389',
    projectId: 'chatapp-3acae',
    storageBucket: 'chatapp-3acae.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyqBbqzDi_OjCsh2bVa4bjQRREG-Uaj3U',
    appId: '1:1079301383389:ios:edbc7662a6e389c63f6734',
    messagingSenderId: '1079301383389',
    projectId: 'chatapp-3acae',
    storageBucket: 'chatapp-3acae.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2REfrxwFykN-0QlNF-yAJhCSw0US64d8',
    appId: '1:1079301383389:web:357ca612a97957f93f6734',
    messagingSenderId: '1079301383389',
    projectId: 'chatapp-3acae',
    authDomain: 'chatapp-3acae.firebaseapp.com',
    storageBucket: 'chatapp-3acae.firebasestorage.app',
    measurementId: 'G-B17RG17GXZ',
  );

}