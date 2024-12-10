import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:move_university_subject/app.dart';
import 'package:move_university_subject/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await addTestData();
  // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform,
  // );
  print('시작1');
  runApp(const MoveUniversityApp());
}


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