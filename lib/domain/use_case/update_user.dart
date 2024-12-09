import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/core/util/util.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : update_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UpdateUserUseCase implements IUseCase<Result<String>, UpdateUserParams> {
  final IUserRepository _repository;

  UpdateUserUseCase(this._repository);

  @override
  Future<Result<String>> call(UpdateUserParams params) async {
    try {
      await _repository.update(params.user);
      return Result.success('SUCCESS');
    } catch (e) {
      return Result.failure(ServerFailure('USE CASE ERROR : ${e.toString()}'));
    }
  }
}

class UpdateUserParams {
  final UserEntity user;

  UpdateUserParams(this.user);
}