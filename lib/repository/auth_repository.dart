import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../barrel/utils.dart';

class AuthRepository {
  Future<http.Response> login(String email, String pass) async {
    final String url = dotenv.env['LOGIN']!;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.mobile &&
        connectivity != ConnectivityResult.wifi) {
      throw NoInternetException(message: 'Please connect to a internet!');
    }

    final client = http.Client();

    Map<String, dynamic> body = {'email': email, 'password': int.parse(pass)};

    try {
      final response = await client
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: timeoutSeconds));

      if (kDebugMode) {
        print('\n----------Login------------\n\n'
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

  Future<http.Response> registration(
      String name, String email, String pass) async {
    final String url = dotenv.env['REGISTRATION']!;
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.mobile &&
        connectivity != ConnectivityResult.wifi) {
      throw NoInternetException(message: 'Please connect to a internet!');
    }

    final client = http.Client();

    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'password': int.parse(pass)
    };

    try {
      final response = await client
          .post(
            Uri.parse(url),
            headers: {
              'X-FakeAPI-Action': 'register',
              "Content-Type": "application/json"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 15));

      if (kDebugMode) {
        print('\n----------Registration------------\n\n'
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
