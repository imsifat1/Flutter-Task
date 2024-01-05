part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class OnGetUserListEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class OnUpdateUserEvent extends UserEvent {
  final int userId;
  final String name, email, location;
  const OnUpdateUserEvent({
    required this.userId,
    required this.name,
    required this.email,
    required this.location,
  });
  @override
  List<Object?> get props => [userId, name, email, location];
}
