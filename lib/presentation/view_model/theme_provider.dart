import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// @Project name    : move_university_subject
/// @Class           : theme_provider.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 11..
/// Description      : 
///

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void toggleTheme(BuildContext context) {
    print('현재 상태: $state');
    // 현재 디바이스 테마 확인
    final platformBrightness = MediaQuery.of(context).platformBrightness;

    // 시스템 테마인 경우 디바이스 상태에 따라 테마 변경
    if (state == ThemeMode.system) {
      state = platformBrightness == Brightness.light
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      // 현재 상태가 light/dark이면 반대로 변경
      state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    }
    print('변경된 상태: $state');
  }

  bool get isDarkMode => state == ThemeMode.dark;
}