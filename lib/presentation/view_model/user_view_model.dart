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

  DocumentSnapshot? lastDocument; // 마지막 문서 추적
  bool isFetching = false; // 중복 호출 방지

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isFetching) return;
    isFetching = true;

    if (isRefresh) {
      state = const AsyncValue.loading();
      lastDocument = null;
    }

    try {
      final users = await getUserUseCase(GetUsersParams(startAfter: lastDocument));

      if (isRefresh) {
        state = AsyncValue.data(users);
      } else {
        final currentUsers = state.value ?? [];
        state = AsyncValue.data([...currentUsers, ...users]);
      }

      if (users.isNotEmpty) {
        lastDocument = users.last.createdAt as DocumentSnapshot;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      isFetching = false;
    }
  }

  Future<void> addUser(UserEntity user) async {
    state = const AsyncValue.loading();

    try {
      await createUserUseCase(CreateUserParams(user));
      await fetchUsers(isRefresh: true);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> editUser(UserEntity user) async {
    state = const AsyncValue.loading();

    try {
      await updateUserUseCase(UpdateUserParams(user));
      await fetchUsers(isRefresh: true);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> removeUser(String userId) async {
    state = const AsyncValue.loading();

    try {
      await deleteUserUseCase(DeleteUserParams(userId));
      await fetchUsers(isRefresh: true);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}