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
    final platformBrightness = MediaQuery.of(context).platformBrightness;

    if (state == ThemeMode.system) {
      state = platformBrightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
    } else {
      state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    }

  }

  bool get isDarkMode => state == ThemeMode.dark;
}