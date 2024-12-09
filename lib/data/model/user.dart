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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      address: doc['address'],
      createdAt: doc['createAt'],
      updatedAt: doc['updateAt'],
    );
  }
}