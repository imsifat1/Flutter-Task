part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserListLoadedState extends UserState {
  final List<User> userList;
  const UserListLoadedState({required this.userList});
  @override
  List<Object?> get props => [userList];
}

class UserListLoadedFailedState extends UserState {
  final String message;
  const UserListLoadedFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}

class UserUpdateSuccessState extends UserState {
  final User user;
  const UserUpdateSuccessState({required this.user});
  @override
  List<Object?> get props => [user];
}

class UserUpdateFailedState extends UserState {
  final String message;
  const UserUpdateFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}
