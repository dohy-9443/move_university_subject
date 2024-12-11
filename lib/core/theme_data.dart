import 'package:flutter/material.dart';

///
/// @Project name    : move_university_subject
/// @Class           : theme_data.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 11..
/// Description      : 
///

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4A90E2), // 메인 색상 (파란색 계열)
  scaffoldBackgroundColor: Colors.white, // 배경색
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4A90E2), // 주요 색상
    secondary: Color(0xFF50E3C2), // 강조 색상 (밝은 초록색)
    onPrimary: Colors.white, // 버튼 텍스트 색상
    onSecondary: Colors.black, // 강조 텍스트 색상
    surface: Colors.white, // 카드 배경 색상
    onSurface: Colors.black, // 카드 텍스트 색상
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A90E2), // 버튼 배경색
      foregroundColor: Colors.white, // 버튼 텍스트 색상
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1D3557), // 메인 색상 (진한 파란색)
  scaffoldBackgroundColor: const Color(0xFF121212), // 배경색
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1D3557), // 주요 색상
    secondary: Color(0xFF457B9D), // 강조 색상 (밝은 파란색)
    onPrimary: Colors.white, // 버튼 텍스트 색상
    onSecondary: Colors.white, // 강조 텍스트 색상
    surface: Color(0xFF1E1E1E), // 카드 배경 색상
    onSurface: Colors.white70, // 카드 텍스트 색상
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1D3557), // 버튼 배경색
      foregroundColor: Colors.white, // 버튼 텍스트 색상
    ),
  ),
);
