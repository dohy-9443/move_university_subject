import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:move_university_subject/app.dart';
import 'package:move_university_subject/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setting();
  runApp(const MoveUniversityApp());
}

setting() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await addTestData(); 테스트용 데이터 생성
  await initializeDateFormatting('ko', null);
}