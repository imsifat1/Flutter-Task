import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_imran/route/route_manager.dart';

import '../../../barrel/model.dart';
import '../../../barrel/utils.dart';
import '../bloc/bloc/user_bloc.dart';

class UserList extends StatelessWidget {
  UserList({super.key});
  final _mySharedPreference = MySharedPreference();
  final List<User> _userList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(OnGetUserListEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                _mySharedPreference.remove(MySharedPreference.currentUser);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteManager.login, (route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserListLoadedState) {
              _userList.addAll(state.userList);
            }
          },
          builder: (context, state) {
            if (state is UserListLoadedState) {
              return ListView.separated(
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_userList[index].name ?? ''),
                    subtitle: Text(_userList[index].email ?? ''),
                    leading: CachedNetworkImage(
                      imageUrl: _userList[index].profilepicture ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    trailing: Text(_userList[index].location ?? ''),
                    onTap: () async {
                      final result = await Navigator.of(context).pushNamed(
                          RouteManager.userDetails,
                          arguments: _userList[index]);

                      if (result as bool) {
                        context.read<UserBloc>().add(OnGetUserListEvent());
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              );
            } else if (state is UserListLoadedFailedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(OnGetUserListEvent());
                        },
                        child: Text('${state.message}Try again?'))
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }
}
