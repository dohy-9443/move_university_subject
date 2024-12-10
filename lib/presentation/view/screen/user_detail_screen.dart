import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/core/di/dependency_injection.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_detail_screen.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///



class UserDetailScreen extends ConsumerWidget {
  final UserEntity user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.watch(userViewModelProvider.notifier);

    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final addressController = TextEditingController(text: user.address);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
        actions: [
          IconButton(
            onPressed: () async {
              await userViewModel.removeUser(user.id);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: user.id,
              child: CircleAvatar(
                radius: 40,
                child: Text(user.name[0]),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: nameController.text.isEmpty ? '필수 입력 사항입니다.' : null,
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailController.text.isEmpty ? '필수 입력 사항입니다.' : null,
              ),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                errorText: addressController.text.isEmpty ? '필수 입력 사항입니다.' : null,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('입력 오류'),
                      content: const Text('모든 필드를 입력해야 합니다.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                final updatedUser = UserEntity(
                  id: user.id,
                  name: nameController.text,
                  email: emailController.text,
                  address: addressController.text,
                  createdAt: user.createdAt,
                  updatedAt: Timestamp.now(),
                );
                userViewModel.editUser(updatedUser);
                Navigator.pop(context);
              },
              child: const Text('수정'),
            ),
          ],
        ),
      ),
    );
  }
}
