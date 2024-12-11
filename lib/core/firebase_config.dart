import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
///
/// @Project name    : move_university_subject
/// @Class           : firebase_config.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 11..
/// Description      : 
///

class FirebaseConfig {

  static FirebaseOptions get options {
    FirebaseOptions firebaseOptions = FirebaseOptions(
        apiKey: dotenv.env[Platform.isAndroid ? 'ANDROID_API_KEY' : 'IOS_API_KEY']!,
        appId: dotenv.env[Platform.isAndroid ? 'ANDROID_APP_ID' : 'IOS_APP_ID']!,
        messagingSenderId: dotenv.env[Platform.isAndroid ? 'ANDROID_MESSAGING_SENDER_ID' : 'IOS_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env[Platform.isAndroid ? 'ANDROID_PROJECT_ID' : 'IOS_PROJECT_ID']!,
        storageBucket: dotenv.env[Platform.isAndroid ? 'ANDROID_STORAGE_BUCKET' : 'IOS_STORAGE_BUCKET']!,
    );

    if (!Platform.isAndroid) {
      return firebaseOptions.copyWith(iosBundleId: dotenv.env['IOS_BUNDLE_ID']!,);
    } else {
      return firebaseOptions;
    }
  }
}