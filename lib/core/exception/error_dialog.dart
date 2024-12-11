import 'package:flutter/material.dart';
import 'package:move_university_subject/core/util/navigator_key.dart';

///
/// @Project name    : move_university_subject
/// @Class           : error_dialog.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 11..
/// Description      : 
///

void showErrorDialog(String errorMessage) {
  if (navigatorKey.currentContext == null) return;

  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: const Text('오류 발생'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('확인'),
        ),
      ],
    ),
  );
}