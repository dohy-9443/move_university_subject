import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/firebase_config.dart';

///
/// @Project name    : move_university_subject
/// @Class           : setting.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 13..
/// Description      : 
///

class Setting {

// 앱 초기화 작업
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await Firebase.initializeApp(
      options: FirebaseConfig.options,
    );
    // await addTestData(); // 테스트용 데이터 생성
    await initializeDateFormatting('ko', null);
    log('앱 초기화 완료');
  }

// Flutter 에러 핸들링 설정
  static void setupFlutterErrorHandling() {
    FlutterError.onError = (FlutterErrorDetails details) {
      log('Flutter 내부 ERROR', error: details.exception, stackTrace: details.stack);
      debugPrint('FlutterError: ${details.exception}');
      debugPrintStack(stackTrace: details.stack);
      FlutterError.presentError(details);

      if (!kDebugMode) {
        showErrorDialog(details.exception.toString());
      }
    };
  }

// Flutter 외부에서 발생한 에러 처리
  static void handleUncaughtError(Object error, StackTrace stackTrace) {
    log('Flutter 외부 ERROR', error: error, stackTrace: stackTrace);
    debugPrint('외부 ERROR: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
}