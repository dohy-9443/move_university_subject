import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/core/util/result.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : delete_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class DeleteUserUseCase implements IUseCase<Result<String>, DeleteUserParams> {
  final IUserRepository _repository;

  DeleteUserUseCase(this._repository);

  @override
  Future<Result<String>> call(DeleteUserParams params) async {
    try {
      await _repository.delete(params.userId);
      return Result.success('SUCCESS');
    } catch (e) {
      return Result.failure(ServerFailure('USE CASE ERROR : ${e.toString()}'));
    }
  }
}

class DeleteUserParams {
  final String userId;

  DeleteUserParams(this.userId);
}