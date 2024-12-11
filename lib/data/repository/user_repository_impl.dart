import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/data/data_sources/data_source.dart';
import 'package:move_university_subject/domain/entity/user.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_repository_impl.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<UserEntity>>> fetch({DocumentSnapshot<Object?>? startAfter}) async {
    try {
      final userModels = await _remoteDataSource.fetch(startAfter: startAfter);
      final userEntities = userModels.map((model) => model.toEntity()).toList();

      return Result.success(userEntities);
    } catch (e) {
      return Result.failure(ServerFailure('repository implements user fetch error : ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> create(UserEntity user) async {
    try {
      await _remoteDataSource.create(user.toModel());
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerFailure("repository implements create user error : ${e.toString()}"));
    }
  }

  @override
  Future<Result<void>> update(UserEntity user) async {
    try {
      await _remoteDataSource.update(user.toModel());
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerFailure("repository implements update user error : ${e.toString()}"));
    }
  }

  @override
  Future<Result<void>> delete(String userId) async {
    try {
      await _remoteDataSource.delete(userId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(ServerFailure("repository implements delete user error : ${e.toString()}"));
    }
  }
}