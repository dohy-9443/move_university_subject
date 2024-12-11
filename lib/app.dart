import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/core/theme_data.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/presentation/view/screen/screen.dart';
import 'package:move_university_subject/presentation/view_model/theme_provider.dart';

///
/// @Project name    : move_university_subject
/// @Class           : app.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class MoveUniversityApp extends ConsumerWidget {
  const MoveUniversityApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Move University',
      theme: lightTheme, // 라이트 모드 테마
      darkTheme: darkTheme, // 다크 모드 테마
      themeMode: themeMode, // 현재 테마 모드
      home: const UserScreen(),
    );
  }
}
