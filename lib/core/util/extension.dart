import 'package:move_university_subject/data/model/model.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : extension.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}