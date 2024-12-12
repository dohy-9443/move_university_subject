import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/presentation/view/widget/widget.dart';
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

    return AlertDialog(
      title: const Text('Create User'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                controller: nameController,
                labelText: 'Name',
              ),
              const Gap(height: 16,),
              TextInput(
                controller: emailController,
                labelText: 'Email',
              ),
              const Gap(height: 16,),
              TextInput(
                controller: addressController,
                labelText: 'Address',
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
}
