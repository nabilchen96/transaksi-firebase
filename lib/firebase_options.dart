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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCvuwiRjPM-Bue49jq1euzUW5LNMfI3RKQ',
    appId: '1:573123115564:web:ec50ca95747a026ffdaf89',
    messagingSenderId: '573123115564',
    projectId: 'mukti-system',
    authDomain: 'mukti-system.firebaseapp.com',
    storageBucket: 'mukti-system.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMmjjWOUjz0epXSLoaMdGZIwii4TcJTHY',
    appId: '1:573123115564:android:e3499596c44f9963fdaf89',
    messagingSenderId: '573123115564',
    projectId: 'mukti-system',
    storageBucket: 'mukti-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMQMP6VtItNfich6HN3CVyC3Mlry6RBN0',
    appId: '1:573123115564:ios:482ac7b13b1ba356fdaf89',
    messagingSenderId: '573123115564',
    projectId: 'mukti-system',
    storageBucket: 'mukti-system.appspot.com',
    iosClientId: '573123115564-0dp552nafjk0g602jvaa02k9p432ss2i.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterNewApp3',
  );
}
