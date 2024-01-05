import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../barrel/widgets.dart';
import '../../../route/route_manager.dart';
import '../bloc/auth_bloc.dart';

class Registration extends StatelessWidget {
  Registration({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              MyProgressIndicator.circularProgressIndicator(context);
            }
            if (state is RegistrationSuccessState) {
              MyProgressIndicator.dismiss(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successfully Registered!')));
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteManager.userList, (route) => false);
            }
            if (state is RegistrationFailedState) {
              MyProgressIndicator.dismiss(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text('Welcome', style: TextStyle(fontSize: 40))),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    controller: _nameTextController,
                    hintText: 'Please enter your name here',
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _emailTextController,
                    hintText: 'Please enter your email here',
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _passwordTextController,
                    hintText: 'Please enter your password here',
                    obscureField: true,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(OnRegistrationEvent(
                            name: _nameTextController.text,
                            email: _emailTextController.text,
                            pass: _passwordTextController.text));
                      }
                    },
                    child: const Text('Registration'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
