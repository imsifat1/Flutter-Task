import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../barrel/utils.dart';

class UserRepository {
  Future<http.Response> getUserList() async {
    final String url = dotenv.env['USER_LIST']!;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.mobile &&
        connectivity != ConnectivityResult.wifi) {
      throw NoInternetException(message: 'Please connect to a internet!');
    }

    final client = http.Client();

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${currentUser?.token}"},
      ).timeout(const Duration(seconds: timeoutSeconds));

      if (kDebugMode) {
        print('\n----------User List------------\n\n'
            'response:>>>>> ${response.body}');
      }

      client.close();
      return response;
    } on TimeoutException {
      client.close();
      throw ConnectionTimedOutException(message: 'Connection Timed out');
    } catch (e) {
      client.close();
      throw BadRequestException(message: 'Something went wrong!');
    }
  }

  Future<http.Response> updateUser(
      {required int userId,
      required String name,
      required String email,
      required String location}) async {
    String url = dotenv.env['USER_LIST']!;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.mobile &&
        connectivity != ConnectivityResult.wifi) {
      throw NoInternetException(message: 'Please connect to a internet!');
    }

    final client = http.Client();

    url += '/$userId';

    final Map<String, dynamic> data = {
      'id': userId,
      'name': name,
      'email': email,
      'location': location
    };

    try {
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                "Authorization": "Bearer ${currentUser?.token}"
              },
              body: json.encode(data))
          .timeout(const Duration(seconds: timeoutSeconds));

      if (kDebugMode) {
        print('\n----------User Update------------\n\n'
            'response:>>>>> ${response.body}');
      }

      client.close();
      return response;
    } on TimeoutException {
      client.close();
      throw ConnectionTimedOutException(message: 'Connection Timed out');
    } catch (e) {
      client.close();
      throw BadRequestException(message: 'Something went wrong!');
    }
  }
}
