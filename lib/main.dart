import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:move_university_subject/app.dart';
import 'package:move_university_subject/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoveUniversityApp());
}
