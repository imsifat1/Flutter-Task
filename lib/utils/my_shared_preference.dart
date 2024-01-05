import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../barrel/model.dart';

class MySharedPreference {
  Future<SharedPreferences>? _prefs;

  static const String currentUser = "b7688989";

  MySharedPreference() {
    _prefs = SharedPreferences.getInstance();
  }

  Future<void> setUser(User user) async {
    final SharedPreferences prefs = await _prefs!;
    await prefs.setString(currentUser, json.encode(user.toJson()));
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await _prefs!;

    if (prefs.containsKey(currentUser)) {
      var data = json.decode(prefs.get(currentUser) as String);
      User user = User.fromJson(data);
      return user;
    }

    return null;
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await _prefs!;

    if (prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }
}
