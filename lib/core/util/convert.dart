import 'package:cloud_firestore/cloud_firestore.dart';

///
/// @Project name    : move_university_subject
/// @Class           : convert.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

DateTime timestampToDateTime(Timestamp timestamp) {
  return DateTime.parse(timestamp.toDate().toString());
}