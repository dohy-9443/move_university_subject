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

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isFetching || !hasMore) return; // 중복 호출 또는 마지막 페이지일 경우 종료
    print('fetchUsers 호출됨. isRefresh: $isRefresh');
    isFetching = true;

    try {
      if (isRefresh) {
        state = const AsyncValue.loading();
        lastDocument = null;
        hasMore = true; // 새로고침 시 `hasMore` 초기화
      }

      final users = await fetchDataWithRetry();

      if (users.isEmpty) {
        hasMore = false;
      }

      final List<UserEntity> updatedUsers = isRefresh
          ? users
          : [...(state.value ?? []), ...users];

      updatedUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // 최신순 정렬
      state = AsyncValue.data(updatedUsers);
      print('현재 리스트 개수: ${updatedUsers.length}');

      if (users.isNotEmpty) {
        lastDocument = await _getLastDocumentSnapshot(users.last.id);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      isFetching = false;
    }
  }

  Future<List<UserEntity>> fetchDataWithRetry() async {
    const maxAttempts = 5;
    const backoffDelay = Duration(seconds: 2);

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        print('Firestore 호출 시도: $attempt');

        final query = FirebaseFirestore.instance
            .collection('users')
            .orderBy('updatedAt', descending: true)
            .limit(10);

        final snapshot = lastDocument == null
            ? await query.get()
            : await query.startAfterDocument(lastDocument!).get();

        print('Firestore 호출 성공: ${snapshot.docs.length}개 로드됨');
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
        print('Firestore 호출 실패 시도: $attempt, 에러: $e');
        if (attempt == maxAttempts) {
          print('최대 시도 횟수 도달. 에러 던짐.');
          rethrow;
        }
        await Future.delayed(backoffDelay * attempt);
      }
    }
    return [];
  }

  Future<DocumentSnapshot?> _getLastDocumentSnapshot(String userId) async {
    final snapshot = await firestore.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot : null;
  }

  Future<void> addUser(UserEntity user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: Timestamp.now());
      await createUserUseCase(CreateUserParams(updatedUser));

      final currentUsers = state.value ?? [];
      final newUsers = [updatedUser, ...currentUsers];

      newUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // 최신순 정렬
      state = AsyncValue.data(newUsers);

      print('사용자 추가 완료: ${updatedUser.name}');
    } catch (e, stack) {
      print('addUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> editUser(UserEntity user) async {
    try {
      final updatedUser = user.copyWith(updatedAt: Timestamp.now());
      await updateUserUseCase(UpdateUserParams(updatedUser));

      final currentUsers = state.value ?? [];
      final updatedUsers = currentUsers.map((u) {
        return u.id == updatedUser.id ? updatedUser : u;
      }).toList();

      updatedUsers.sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // 최신순 정렬
      state = AsyncValue.data(updatedUsers);

      print('사용자 수정 완료: ${updatedUser.name}');
    } catch (e, stack) {
      print('editUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> removeUser(String userId) async {
    try {
      // 현재 상태를 먼저 업데이트하여 UI 즉시 반영
      final currentUsers = state.value ?? [];
      final updatedUsers = currentUsers.where((u) => u.id != userId).toList();
      state = AsyncValue.data(updatedUsers);
      print('사용자 삭제 후 상태 사용자 수: ${updatedUsers.length}');

      // 서버 요청
      await deleteUserUseCase(DeleteUserParams(userId));
      print('사용자 삭제 완료: $userId');

      // 데이터 부족 시 추가 로드
      if (updatedUsers.length < currentUsers.length && updatedUsers.length < 10) {
        await fetchUsers(isRefresh: false);
      }
    } catch (e, stack) {
      print('removeUser 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }


}