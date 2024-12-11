import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final FirebaseFirestore firestore;
  final GetUserUseCase getUserUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserViewModel({
    required this.firestore,
    required this.getUserUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(const AsyncValue.loading());

  bool hasMore = true; // 마지막 페이지 여부
  DocumentSnapshot? lastDocument; // 마지막 데이터
  bool isFetching = false; // 중복 호출

  // 로드
  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isFetching || !hasMore) return; // 중복 호출 또는 마지막 페이지 일 경우 종료
    isFetching = true;

    try {
      if (isRefresh) {
        state = const AsyncValue.loading();
        lastDocument = null;
        hasMore = true;
      }

      final users = await fetchDataWithRetry();

      if (users.isEmpty) {
        hasMore = false;
      }

      final List<UserEntity> updatedUsers = isRefresh ? users : [...(state.value ?? []), ...users];

      debugPrint("갯수 : ${updatedUsers.length}");

      updatedUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // 최신순 정렬
      state = AsyncValue.data(updatedUsers);

      if (users.isNotEmpty) {
        lastDocument = await _getLastDocumentSnapshot(users.last.id); // 다음을 호출하기 위해
      }

    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      isFetching = false;
    }
  }

  // Firestore에서 데이터 가져오는 요청 , 실패하면 최대 5번까지 재시도
  Future<List<UserEntity>> fetchDataWithRetry() async {
    const maxAttempts = 5; // 재 호출할 횟수
    const backoffDelay = Duration(seconds: 2); // 호출할 간격

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final query = FirebaseFirestore.instance
            .collection('users') // 데이터
            .orderBy('updatedAt', descending: true) // 순서
            .limit(10); // 개수

        final snapshot = lastDocument == null ? await query.get() : await query.startAfterDocument(lastDocument!).get();

        return snapshot.docs.map((doc) {
          return UserEntity(
            id: doc.id,
            name: doc['name'] as String,
            email: doc['email'] as String,
            address: doc['address'] as String,
            createdAt: doc['createdAt'] as Timestamp,
            updatedAt: doc['updatedAt'] as Timestamp,
          );
        }).toList();
      } catch (e) {
        debugPrint('Firestore 호출 실패 시도: $attempt, 에러: $e');
        if (attempt == maxAttempts) {
          debugPrint('최대 시도 횟수 도달. 에러 던짐.');
          rethrow;
        }
        await Future.delayed(backoffDelay * attempt);
      }
    }
    return [];
  }

  // user id 기반으로 DocumentSnapshot 가져오기 (페이징 처리)
  Future<DocumentSnapshot?> _getLastDocumentSnapshot(String userId) async {
    final snapshot = await firestore.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot : null;
  }

  // 추가
  Future<void> addUser(UserEntity user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: Timestamp.now());
      await createUserUseCase(CreateUserParams(updatedUser));

      final currentUsers = state.value ?? [];
      final newUsers = [updatedUser, ...currentUsers];

      newUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      state = AsyncValue.data(newUsers);
      await fetchUsers(isRefresh: true);
    } catch (e, stack) {
      debugPrint('addUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  // 수정
  Future<void> editUser(UserEntity user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: Timestamp.now());
      await updateUserUseCase(UpdateUserParams(updatedUser));

      final currentUsers = state.value ?? [];
      final updatedUsers = currentUsers.map((user) {
        return user.id == updatedUser.id ? updatedUser : user;
      }).toList();

      updatedUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      state = AsyncValue.data(updatedUsers);
      await fetchUsers(isRefresh: true);
    } catch (e, stack) {
      debugPrint('editUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  // 삭제
  Future<void> removeUser(String userId) async {
    try {
      final currentUsers = state.value ?? [];
      final updatedUsers = currentUsers.where((u) => u.id != userId).toList();
      state = AsyncValue.data(updatedUsers);

      await deleteUserUseCase(DeleteUserParams(userId));

      if (updatedUsers.length < currentUsers.length && updatedUsers.length < 10) {
        await fetchUsers(isRefresh: false);
      }
    } catch (e, stack) {
      debugPrint('removeUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }
}