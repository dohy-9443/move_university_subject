import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/data/data_sources/data_source.dart';
import 'package:move_university_subject/data/repository/repository.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';
import 'package:move_university_subject/domain/use_case/use_case.dart';
import 'package:move_university_subject/presentation/view_model/view_model.dart';

///
/// @Project name    : move_university_subject
/// @Class           : dependency_injection.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

final firebaseFireStoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final remoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(ref.watch(firebaseFireStoreProvider));
});

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(remoteDataSourceProvider));
});

final getUsersUseCaseProvider = Provider<GetUserUseCase>((ref) {
  return GetUserUseCase(ref.watch(userRepositoryProvider));
});

final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
  return CreateUserUseCase(ref.watch(userRepositoryProvider));
});

final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) {
  return UpdateUserUseCase(ref.watch(userRepositoryProvider));
});

final deleteUserUseCaseProvider = Provider<DeleteUserUseCase>((ref) {
  return DeleteUserUseCase(ref.watch(userRepositoryProvider));
});

final userViewModelProvider = StateNotifierProvider<UserViewModel, AsyncValue<List<UserEntity>>>((ref) {
  return UserViewModel(
    firestore: ref.watch(firebaseFireStoreProvider),
    getUserUseCase: ref.watch(getUsersUseCaseProvider),
    createUserUseCase: ref.watch(createUserUseCaseProvider),
    updateUserUseCase: ref.watch(updateUserUseCaseProvider),
    deleteUserUseCase: ref.watch(deleteUserUseCaseProvider),
  );
});