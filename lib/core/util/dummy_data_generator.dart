import 'package:cloud_firestore/cloud_firestore.dart';

///
/// @Project name    : move_university_subject
/// @Class           : dummy_data_generator.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

Future<void> addTestData() async {
  final firestore = FirebaseFirestore.instance;
  final usersCollection = firestore.collection('users');

  for (int i = 0; i < 200; i++) {
    await usersCollection.add({
      'id': 'id_$i',
      'name': 'User $i',
      'email': 'user$i@example.com',
      'address': 'Address $i',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  print('200개의 테스트 데이터가 추가되었습니다.');
}