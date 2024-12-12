import 'package:move_university_subject/core/exception/exception.dart';
import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/core/util/result.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : create_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class CreateUserUseCase implements IUseCase<Result<String>, CreateUserParams> {
  final IUserRepository _repository;

  CreateUserUseCase(this._repository);

  @override
  Future<Result<String>> call(CreateUserParams params) async {
    try {
      await _repository.create(params.user);
      return Result.success('SUCCESS');
    } catch (e) {
      return Result.failure(ServerFailure('USE CASE ERROR : ${e.toString()}'));
    }
  }
}

class CreateUserParams {
  final UserEntity user;

  CreateUserParams(this.user);
}