import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/domain/entity/entity.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : update_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UpdateUserUseCase implements IUseCase<void, UpdateUserParams> {
  final IUserRepository _repository;

  UpdateUserUseCase(this._repository);

  @override
  Future<void> call(UpdateUserParams params) async {
    final result = await _repository.update(params.user);

    if (result.isFailure) throw Exception(result.error?.message ?? 'USE CASE ERROR');
    return result.data;
  }
}

class UpdateUserParams {
  final UserEntity user;

  UpdateUserParams(this.user);
}