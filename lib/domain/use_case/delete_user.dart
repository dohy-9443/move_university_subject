import 'package:move_university_subject/core/use_case/use_cases.dart';
import 'package:move_university_subject/domain/repository/repository.dart';

///
/// @Project name    : move_university_subject
/// @Class           : delete_user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class DeleteUserUseCase implements IUseCase<void, DeleteUserParams> {
  final IUserRepository _repository;

  DeleteUserUseCase(this._repository);

  @override
  Future<void> call(DeleteUserParams params) async {
    final result = await _repository.delete(params.userId);

    if (result.isFailure) throw Exception(result.error?.message ?? 'USE CASE ERROR');
    return result.data;
  }
}

class DeleteUserParams {
  final String userId;

  DeleteUserParams(this.userId);
}