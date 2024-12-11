import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/core/di/dependency_injection.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/presentation/view/widget/widget.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_detail_screen.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///



class UserDetailScreen extends ConsumerStatefulWidget {
  final UserEntity user;

  const UserDetailScreen({super.key, required this.user});

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    addressController = TextEditingController(text: widget.user.address);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          '회원 관리',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await userViewModel.removeUser(widget.user.id);
              navigator.pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Hero(
                      tag: widget.user.id,
                      child: CircleAvatar(
                        radius: 40,
                        child: Text(widget.user.name[0]),
                      ),
                    ),
                    const Gap(height: 16,),
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
                    const Gap(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildDateInfo('Created At', widget.user.createdAt),
                        buildDateInfo('Updated At', widget.user.updatedAt),
                      ],
                    ),
                    const Gap(height: 16,),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final updatedUser = widget.user.copyWith(
                            name: nameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            updatedAt: Timestamp.now(),
                          );
                          userViewModel.editUser(updatedUser);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('수정'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
