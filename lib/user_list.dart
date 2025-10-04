// lib/user_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koffeekodes_task/create_team_screen.dart';
import 'package:koffeekodes_task/users/user_list_cubit.dart';
import 'package:koffeekodes_task/users/user_list_state.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserListCubit>().fetchUsers();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<UserListCubit>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (cubit.hasMore && !(cubit.state is UserListLoading)) {
        cubit.fetchUsers(isLoadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateTeamScreen()));
            },
          ),
        ],
      ),
      body: BlocConsumer<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading && !(state is UserListLoaded)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            final users = state.users;
            return ListView.builder(
              controller: _scrollController,
              itemCount: users.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == users.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final user = users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      '${user.profile.firstName} ${user.profile.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(user.role.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.isActive ? "Active" : "Inactive",
                          style: TextStyle(
                            color: user.isActive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xff00a0aa)),
                          onPressed: () {},
                        ),
                        IconButton(icon: const Icon(Icons.delete,
                              color: Color(0xff00a0aa)),
                          onPressed: () {
                            context.read<UserListCubit>().deleteUser(user.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is UserListError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {},
      ),
    );
  }
}
