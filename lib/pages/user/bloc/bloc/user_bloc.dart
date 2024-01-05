import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../barrel/model.dart';
import '../../../../barrel/repository.dart';
import '../../../../barrel/utils.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepo = UserRepository();
  UserBloc() : super(UserInitial()) {
    on<OnGetUserListEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final response = await _userRepo.getUserList();
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          if (jsonData['data'] != null) {
            List<User> userList =
                List<User>.from(jsonData['data'].map((x) => User.fromJson(x)));
            emit(UserListLoadedState(userList: userList));
            return;
          } else {
            emit(UserListLoadedFailedState(message: jsonData['message']));
            return;
          }
        }
        emit(const UserListLoadedFailedState(message: 'Failed to get data!'));
        return;
      } on AppException catch (error) {
        emit(UserListLoadedFailedState(message: error.message));
        return;
      } catch (e) {
        emit(UserListLoadedFailedState(message: e.toString()));
        return;
      }
    });
    on<OnUpdateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final response = await _userRepo.updateUser(
          userId: event.userId,
          name: event.name,
          email: event.email,
          location: event.email,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          if (jsonData != null) {
            emit(UserUpdateSuccessState(user: User.fromJson(jsonData)));
            return;
          }
          emit(UserUpdateFailedState(message: jsonData['Message']));
          return;
        }
        emit(const UserUpdateFailedState(message: 'Failed to update user!'));
        return;
      } on AppException catch (error) {
        emit(UserUpdateFailedState(message: error.message));
        return;
      } catch (e) {
        emit(UserUpdateFailedState(message: e.toString()));
        return;
      }
    });
  }
}
