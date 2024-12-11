import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move_university_subject/core/di/di.dart';
import 'package:move_university_subject/presentation/view/screen/user_detail_screen.dart';
import 'package:move_university_subject/presentation/view/widget/widget.dart';
import 'package:move_university_subject/presentation/view_model/theme_provider.dart';

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
    super.initState();
    ref.read(userViewModelProvider.notifier).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userViewModelProvider.notifier);
    final usersState = ref.watch(userViewModelProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원 관리',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode ? Colors.grey : Colors.yellow,
            ),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      body: usersState.when(
        data: (users) {
          if (users.isEmpty) {
            return EmptyScreen(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CreateUserDialog(userViewModel: userViewModel),
                );
              },
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // 스크롤이 하단에 위치할 쯤 호출
              if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
                userViewModel.fetchUsers();
              }
              return true;
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListItem(
                    user: user,
                    onDismissed: (direction) async {
                      await userViewModel.removeUser(user.id);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailScreen(user: user),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(height: 8,);
                },
              ),
            ),
          );
        },
        error: (err, stack) {
          debugPrint('err : $err');
          return Center(
            child: Text(err.toString()),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
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
