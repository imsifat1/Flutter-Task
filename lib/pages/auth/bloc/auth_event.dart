part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class OnLoginEvent extends AuthEvent{
  final String email, pass;

  const OnLoginEvent({required this.email, required this.pass});

  @override
  List<Object?> get props => [email, pass];
}

class OnRegistrationEvent extends AuthEvent{
  final String name, email, pass;

  const OnRegistrationEvent({required this.name, required this.email, required this.pass});

  @override
  List<Object?> get props => [name, email, pass];
}
