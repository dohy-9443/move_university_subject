import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  for (int i = 0; i < 100; i++) {
    await usersCollection.add({
      'id': 'id_$i',
      'name': 'User $i',
      'email': 'user$i@example.com',
      'address': 'Address $i',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  debugPrint('200개의 테스트 데이터가 추가되었습니다.');
}