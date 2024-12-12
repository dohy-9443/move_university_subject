import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/app.dart';
import 'package:move_university_subject/core/setting.dart';


void main() {
  runZonedGuarded(() async {
    await Setting.initializeApp();
    Setting.setupFlutterErrorHandling();
    runApp(const ProviderScope(child: MoveUniversityApp()));
  }, Setting.handleUncaughtError,);
}
