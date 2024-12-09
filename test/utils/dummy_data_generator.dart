import 'package:cloud_firestore/cloud_firestore.dart';

///
/// @Project name    : move_university_subject
/// @Class           : dummy_data_generator.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

Future<void> dummyGenerate(int count) async {
  final fireStore = FirebaseFirestore.instance;

  for (int i = 0; i < count; i++) {
    final id = fireStore.collection('users').doc().id;
    final timestamp = Timestamp.now();
    final user = {
      'id': id,
      'name': 'User $i',
      'email': 'user_$i@example.com',
      'address': 'Address $i',
      'createAt': timestamp,
      'updateAt': timestamp,
    };

    await fireStore.collection('users').doc(id).set(user);
  }
}