import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:move_university_subject/data/model/model.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_remote_data_source.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UserRemoteDataSource {
  final FirebaseFirestore _fireStore;

  UserRemoteDataSource(this._fireStore);

  Future<List<UserModel>> fetch({ DocumentSnapshot? startAfter, int limit = 10 }) async {
    final query = _fireStore.collection('users').limit(limit);
    final snapshot = startAfter == null ? await query.get() : await query.startAfterDocument(startAfter).get();

    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }
}