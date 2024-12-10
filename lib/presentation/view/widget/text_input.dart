import 'package:flutter/material.dart';

///
/// @Project name    : move_university_subject
/// @Class           : text_input.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  const TextInput({super.key, required this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: controller.text.isEmpty ? '필수 입력 사항입니다.' : null,
      ),
    );
  }
}
