part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends AuthState {
  final User user;
  const LoginSuccessState({required this.user});
  @override
  List<Object?> get props => [user];
}

class LoginFailedState extends AuthState {
  final String message;

  const LoginFailedState({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegistrationSuccessState extends AuthState {
  final User user;
  const RegistrationSuccessState({required this.user});
  @override
  List<Object?> get props => [user];
}

class RegistrationFailedState extends AuthState {
  final String message;
  const RegistrationFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}
