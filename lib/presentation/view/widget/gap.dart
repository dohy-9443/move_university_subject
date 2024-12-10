import 'package:flutter/material.dart';

///
/// @Project name    : move_university_subject
/// @Class           : gap.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

class Gap extends StatelessWidget {
  final double width;
  final double height;
  const Gap({super.key, this.width = 0, this.height = 0});

  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height,);
}
