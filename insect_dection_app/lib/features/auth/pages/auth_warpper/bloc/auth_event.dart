part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final AuthUserInfo userInfo;

  const AuthUserChanged(this.userInfo);
  @override
  List<Object?> get props => [userInfo];
}

class AuthLogoutRequested extends AuthEvent {}
