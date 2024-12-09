import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : dummy_data_generator.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

final List<Map<String, dynamic>> dummyData = List.generate(200, (index) {
  return {
    'id': 'id_$index',
    'name': 'User $index',
    'email': 'user$index@example.com',
    'address': 'Address $index',
    'createdAt': Timestamp.now(),
    'updatedAt': Timestamp.now(),
  };
});

final List<UserEntity> dummyUserEntities = dummyData.map((data) {
  return UserEntity(
    id: data['id'] as String,
    name: data['name'] as String,
    email: data['email'] as String,
    address: data['address'] as String,
    createdAt: data['createdAt'] as Timestamp,
    updatedAt: data['updatedAt'] as Timestamp,
  );
}).toList();