import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Container(),
        ),
      ),
    );
  }
}
