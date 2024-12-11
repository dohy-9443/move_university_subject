import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/presentation/view_model/user_view_model.dart';

///
/// @Project name    : move_university_subject
/// @Class           : CreateUserDialog.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : Dialog for creating a new user.
///

class CreateUserDialog extends StatelessWidget {
  final UserViewModel userViewModel;

  const CreateUserDialog({super.key, required this.userViewModel});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return AlertDialog(
          title: const Text('Create User'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    maxLength: 20,
                    decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: keyboardType('Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이름을 작성해주세요.';
                      }
                      if (value.length > 20) {
                        return '20자 이상 넘어가면 안 됩니다.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: keyboardType('Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력해주세요.';
                      }
                      // 이메일 유효성 검사
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return '이메일 형식에 맞게 작성해주세요.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    keyboardType: keyboardType('Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '주소를 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final user = UserEntity(
                    id: UniqueKey().toString(),
                    name: nameController.text,
                    email: emailController.text,
                    address: addressController.text,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  userViewModel.addUser(user);
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      }
    );
  }
}
