import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/presentation/view/screen/screen.dart';

///
/// @Project name    : move_university_subject
/// @Class           : app.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class MoveUniversityApp extends StatelessWidget {
  const MoveUniversityApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("시작2");
    return ProviderScope(
      child: MaterialApp(
        home: UserScreen(),
      ),
    );
  }
}
