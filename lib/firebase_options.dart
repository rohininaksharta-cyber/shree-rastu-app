import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web Firebase options are not configured.');
    }
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6nYsRkfCol8kL4duutPbt6KVxHkvgua0',
    appId: '1:1080732065371:android:58ddcb1d3f3a1174b7697e',
    messagingSenderId: '1080732065371',
    projectId: 'shree-rastu-vastu-jyotishya',
    storageBucket: 'shree-rastu-vastu-jyotishya.firebasestorage.app',
  );
}
