import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/core/di/di.dart';
import 'package:move_university_subject/presentation/view/screen/user_detail_screen.dart';
import 'package:move_university_subject/presentation/view/widget/widget.dart';

///
/// @Project name    : move_university_subject
/// @Class           : user_screen.
/// @Created by      : baekdonghyun.
/// Created On       : 2024. 12. 10..
/// Description      : 
///

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(userViewModelProvider.notifier).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    print("시작3");
    final userViewModel = ref.watch(userViewModelProvider.notifier);
    final usersState = ref.watch(userViewModelProvider);
    print("시작4");
    print("usersState : ${usersState.isLoading}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 관리'),
      ),
      body: usersState.when(
        data: (users) {
          print('시작5');
          if (users.isEmpty) {
            print('시작6');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_alt_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '회원이 없습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CreateUserDialog(userViewModel: userViewModel),
                      );
                    },
                    child: const Text('첫 회원을 추가 하세요.'),
                  ),
                ],
              ),
            );
          }

          print('시작6');
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
                userViewModel.fetchUsers();
              }
              return true;
            },
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Dismissible(
                  key: Key(user.id),
                  onDismissed: (direction) async {
                    await userViewModel.removeUser(user.id);
                  },
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailScreen(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        error: (err, stack) {
          print('err : $err');
          return Center(
            child: Text(err.toString()),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreateUserDialog(userViewModel: userViewModel),
          );
        },
        child: const Icon(Icons.person_add_alt_1_outlined),
      ),
    );
  }
}
