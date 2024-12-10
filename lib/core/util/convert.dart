import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// @Project name    : move_university_subject
/// @Class           : convert.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 9..
/// Description      : 
///

Widget buildDateInfo(String label, Timestamp timestamp) {
  final dateTime = timestamp.toDate();
  final formattedDate = DateFormat('yyyy-MM-dd a h:mm', 'ko').format(dateTime);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 4),
      Text(
        formattedDate,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ],
  );
}