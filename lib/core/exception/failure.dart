///
/// @Project name    : move_university_subject
/// @Class           : failure.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

abstract class IFailure {
  final String message;

  const IFailure(this.message);
}

class ServerFailure extends IFailure {
  const ServerFailure(String message) : super(message);
}