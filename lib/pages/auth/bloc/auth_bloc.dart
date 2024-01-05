import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_imran/barrel/model.dart';
import 'package:test_imran/repository/auth_repository.dart';
import 'package:test_imran/utils/app_exception.dart';
import 'package:test_imran/utils/my_shared_preference.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();
  final _mySharedPreference = MySharedPreference();
  AuthBloc() : super(AuthInitial()) {
    on<OnLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await _authRepository.login(event.email, event.pass);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          if (jsonData['data'] != null) {
            User user = User.fromJson(jsonData['data']);
            _mySharedPreference.setUser(user);
            emit(LoginSuccessState(user: user));
            return;
          } else {
            emit(LoginFailedState(message: jsonData['message']));
            return;
          }
        }
      } on AppException catch (error) {
        emit(LoginFailedState(message: error.message));
        return;
      } catch (e) {
        emit(LoginFailedState(message: e.toString()));
        return;
      }
    });

    on<OnRegistrationEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await _authRepository.registration(
            event.name, event.email, event.pass);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          if (jsonData['data'] != null) {
            User user = User.fromJson(jsonData['data']);
            _mySharedPreference.setUser(user);
            emit(RegistrationSuccessState(user: user));
            return;
          } else {
            emit(RegistrationFailedState(message: jsonData['message']));
            return;
          }
        }
      } on AppException catch (error) {
        emit(RegistrationFailedState(message: error.message));
        return;
      } catch (e) {
        emit(RegistrationFailedState(message: e.toString()));
        return;
      }
    });
  }
}
