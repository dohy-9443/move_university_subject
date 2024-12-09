import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/use_case/use_case.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_view_model.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UserViewModel extends StateNotifier<AsyncValue<List<UserEntity>>> {
  final GetUserUseCase getUserUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserViewModel({
    required this.getUserUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase
  }) : super(const AsyncValue.loading());

  Future<void> getUser({DocumentSnapshot? startAfter}) async {
    state = const AsyncValue.loading();

    try {
      final users = await getUserUseCase(GetUsersParams(startAfter));
      state = AsyncValue.data(users);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }

  }

  Future<void> addUser(UserEntity user) async {
    state = const AsyncValue.loading();

    try {
      await createUserUseCase(CreateUserParams(user));
      await getUser();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> editUser(UserEntity user) async {
    state = const AsyncValue.loading();

    try {
      await updateUserUseCase(UpdateUserParams(user));
      await getUser();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> removeUser(String userId) async {
    state = const AsyncValue.loading();

    try {
      await deleteUserUseCase(DeleteUserParams(userId));
      await getUser();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}