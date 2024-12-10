import 'package:flutter/material.dart';
import 'package:move_university_subject/domain/entity/entity.dart';

///
/// @Project name    : move_university_subject
/// @Class           : list_item.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

class ListItem extends StatelessWidget {
  final UserEntity user;
  final Function(DismissDirection) onDismissed;
  final VoidCallback onTap;
  const ListItem({super.key, required this.user, required this.onDismissed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(user.id),
      onDismissed: onDismissed,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        leading: Hero(
          tag: user.id,
          child: CircleAvatar(
            child: Text(user.name[0]),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        onTap: onTap,
      ),
    );
  }
}
