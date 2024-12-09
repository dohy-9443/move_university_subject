///
/// @Project name    : move_university_subject
/// @Class           : use_case.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

abstract class IUseCase<Type, Params> {
  Future<Type> call(Params params);
}