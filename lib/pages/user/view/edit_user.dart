import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_imran/barrel/model.dart';
import 'package:test_imran/barrel/widgets.dart';
import 'package:test_imran/pages/user/bloc/bloc/user_bloc.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key, required this.user});
  User user;
  User? _updatedUser;
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _locationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameTextController.text = user.name ?? '';
    _emailTextController.text = user.email ?? '';
    _locationTextController.text = user.location ?? '';

    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is UserUpdateSuccessState) {
          _updatedUser = state.user;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User updated successfully!')));
          Navigator.pop(context, _updatedUser);
        }
        if (state is UserUpdateFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }, builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context, _updatedUser);
            return Future(() => false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit User'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<UserBloc>().add(OnUpdateUserEvent(
                        userId: user.id!,
                        name: _nameTextController.text,
                        email: _emailTextController.text,
                        location: _locationTextController.text));
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Name:'),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: _nameTextController,
                  hintText: 'Enter your name',
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Please input name here...';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text('Email:'),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: _emailTextController,
                  hintText: 'Enter your email',
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Please input email here...';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text('Location:'),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: _locationTextController,
                  hintText: 'Enter your location',
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Please input location here...';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
