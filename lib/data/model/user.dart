import 'package:cloud_firestore/cloud_firestore.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

class UserModel{
  final String id;
  final String name;
  final String email;
  final String address;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Model fromFirestore : Document data is null for id: ${doc.id}');
    }

    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }
}