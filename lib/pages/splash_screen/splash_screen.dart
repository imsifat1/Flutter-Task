import 'package:flutter/material.dart';

import '../../barrel/utils.dart';
import '../../route/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _sharedPreference = MySharedPreference();
  @override
  void initState() {
    super.initState();
    onStart(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Test',
            style: TextStyle(fontSize: 40),
          ),
          Text(
            'Welcome to test app',
            style: TextStyle(fontSize: 25),
          ),
          CircularProgressIndicator.adaptive()
        ],
      )),
    );
  }

  void onStart(BuildContext context) async {
    currentUser = await _sharedPreference.getUser();

    await Future<void>.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;
    if (currentUser != null &&
        currentUser?.id != null &&
        currentUser?.token != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RouteManager.userList, (route) => false);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
        context, RouteManager.login, (route) => false);
  }
}
