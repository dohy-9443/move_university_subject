import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : create_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class CreateUserUseCase implements IUseCase<void, CreateUserParams> {
  final IUserRepository _repository;

  CreateUserUseCase(this._repository);

  @override
  Future<void> call(CreateUserParams params) async {
    final result = await _repository.create(params.user);

    if (result.isFailure) throw Exception(result.error?.message ?? 'USE CASE ERROR');
    return result.data;
  }
}

class CreateUserParams {
  final UserEntity user;

  CreateUserParams(this.user);
}