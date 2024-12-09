import 'package:move_university_subject/core/exception/exception.dart';

///
/// @Project name    : move_university_subject
/// @Class           : result.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class Result<T> {
  final T? data;
  final IFailure? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}