import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : get_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class GetUserUseCase implements IUseCase<List<UserEntity>, GetUsersParams> {
  final IUserRepository _repository;

  GetUserUseCase(this._repository);

  @override
  Future<List<UserEntity>> call(GetUsersParams params) async {
    final result = await _repository.fetch(startAfter: params.startAfter);

    if (result.isFailure) throw Exception(result.error?.message ?? 'USE CASE ERROR');

    return result.data!;
  }
}

class GetUsersParams {
  final DocumentSnapshot? startAfter;

  GetUsersParams({this.startAfter});
}