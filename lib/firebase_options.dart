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
    apiKey: 'AIzaSyCc38DQb61C_0J-b_7t3bY05BsZmOrxyeg',
    appId: '1:221814894500:web:5e35ae5801b661e47fdb31',
    messagingSenderId: '221814894500',
    projectId: 'multi-store-ac7da',
    authDomain: 'multi-store-ac7da.firebaseapp.com',
    storageBucket: 'multi-store-ac7da.appspot.com',
    measurementId: 'G-0KN9MC0MLW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACLTZRD4aZv0ysSQ8527G8X_d6aU990js',
    appId: '1:221814894500:android:0e39eb086ec985157fdb31',
    messagingSenderId: '221814894500',
    projectId: 'multi-store-ac7da',
    storageBucket: 'multi-store-ac7da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWn8KyW3AV_YSM65AIEfDlj_lEIuQrQ4A',
    appId: '1:221814894500:ios:ebccf48389077abf7fdb31',
    messagingSenderId: '221814894500',
    projectId: 'multi-store-ac7da',
    storageBucket: 'multi-store-ac7da.appspot.com',
    androidClientId: '221814894500-j8td77enuh5b96fvuaafk3utj603bpcr.apps.googleusercontent.com',
    iosClientId: '221814894500-rbf7c6dskas0j0en3acp2pm56hk7m3nb.apps.googleusercontent.com',
    iosBundleId: 'com.example.cashback',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWn8KyW3AV_YSM65AIEfDlj_lEIuQrQ4A',
    appId: '1:221814894500:ios:ebccf48389077abf7fdb31',
    messagingSenderId: '221814894500',
    projectId: 'multi-store-ac7da',
    storageBucket: 'multi-store-ac7da.appspot.com',
    androidClientId: '221814894500-j8td77enuh5b96fvuaafk3utj603bpcr.apps.googleusercontent.com',
    iosClientId: '221814894500-rbf7c6dskas0j0en3acp2pm56hk7m3nb.apps.googleusercontent.com',
    iosBundleId: 'com.example.cashback',
  );
}
