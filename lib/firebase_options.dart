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
    apiKey: 'AIzaSyBaHgQ0KICzcHT3UFDtOT3yRGw2krnLjBQ',
    appId: '1:506627182621:web:0cc694de60b9c9e851b6f4',
    messagingSenderId: '506627182621',
    projectId: 'colltech',
    authDomain: 'colltech.firebaseapp.com',
    storageBucket: 'colltech.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMa3LbPTj2cmNNAZm3tbGbdsPRDiSOvs0',
    appId: '1:506627182621:android:5948bb095fb8a98751b6f4',
    messagingSenderId: '506627182621',
    projectId: 'colltech',
    storageBucket: 'colltech.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHHCmq3ijXdNj02juIq5arFoYIlUjTCOA',
    appId: '1:506627182621:ios:3862e933737fb79551b6f4',
    messagingSenderId: '506627182621',
    projectId: 'colltech',
    storageBucket: 'colltech.appspot.com',
    iosBundleId: 'com.example.coltech',
  );
}
