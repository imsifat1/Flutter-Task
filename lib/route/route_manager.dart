import 'package:flutter/material.dart';
import 'package:test_imran/barrel/model.dart';

import '../barrel/view.dart';

class RouteManager {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String userList = '/user-list';
  static const String userDetails = '/user-details';
  static const String editUser = '/edit-user';

  static Route<dynamic> generate(RouteSettings settings) {
    final dynamic args = settings.arguments;
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case registration:
        return MaterialPageRoute(builder: (_) => Registration());
      case userList:
        return MaterialPageRoute(builder: (_) => UserList());
      case userDetails:
        return MaterialPageRoute(
            builder: (_) => UserDetails(
                  user: args as User,
                ));
      case editUser:
        return MaterialPageRoute(
            builder: (_) => EditUser(
                  user: args as User,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No page found!'),
                  ),
                ));
    }
  }
}
