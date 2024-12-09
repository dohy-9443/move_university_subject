import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_repository.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

abstract class IUserRepository {
  Future<Result<List<UserEntity>>> fetch({DocumentSnapshot? startAfter});
  Future<Result<void>> create(UserEntity user);
  Future<Result<void>> update(UserEntity user);
  Future<Result<void>> delete(String userId);
}