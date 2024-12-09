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
      final users = await _remoteDataSource.fetch(startAfter: startAfter);
      return Result.success(users.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Result.failure(ServerFailure('user fetch error : ${e.toString()}'));
    }
  }
}