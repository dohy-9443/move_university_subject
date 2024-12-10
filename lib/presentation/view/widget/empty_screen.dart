import 'package:flutter/material.dart';

///
/// @Project name    : move_university_subject
/// @Class           : empty_screen.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

class EmptyScreen extends StatelessWidget {
  final VoidCallback onPressed;

  const EmptyScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people_alt_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16,),
          const Text(
            '회원이 없습니다.',
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('첫 회원을 추가 하세요.'),
          ),
        ],
      ),
    );
  }
}
