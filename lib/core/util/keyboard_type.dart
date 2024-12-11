import 'package:flutter/material.dart';

///
/// @Project name    : move_university_subject
/// @Class           : keyboard_type.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 12..
/// Description      : 
///


TextInputType keyboardType(String label) {
  if (label == 'Name') {
    return TextInputType.name;
  } else if (label == 'Email') {
    return TextInputType.emailAddress;
  } else {
    return TextInputType.streetAddress;
  }
}