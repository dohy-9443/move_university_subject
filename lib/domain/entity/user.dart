import 'package:cloud_firestore/cloud_firestore.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String address;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });
}