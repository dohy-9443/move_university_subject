import 'package:flutter/material.dart';
import 'package:move_university_subject/core/util/util.dart';

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
        border: const OutlineInputBorder(),
      ),
      maxLength: labelText == 'Name' ? 20 : null,
      keyboardType: keyboardType(labelText!),
      validator: (value) {
        if (labelText == 'Name') {
          if (value == null || value.isEmpty) {
            return '이름을 입력해주세요.';
          }
          if (value.length > 20) {
            return '이름을 20자 미만으로 작성해주세요.';
          }
          return null;
        }

        if (labelText == 'Email') {
          if (value == null || value.isEmpty) {
            return '이메일을 입력해주세요.';
          }
          // 이메일 유효성 검사
          final emailRegex = RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
          if (!emailRegex.hasMatch(value)) {
            return '이메일 형식에 맞게 입력해주세요.';
          }
          return null;
        }

        if (labelText == 'Address') {
          if (value == null || value.isEmpty) {
            return '주소를 입력하세요.';
          }
          return null;
        }
        return null;
      },
    );
  }
}
