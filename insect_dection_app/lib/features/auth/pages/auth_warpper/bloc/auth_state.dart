part of 'auth_bloc.dart';

enum AuthStatus { intial, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUserInfo user;

  const AuthState._({required this.status, required this.user});


  const AuthState.authenticated(AuthUserInfo user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
          user: AuthUserInfo.empty,
        );

  @override
  List<Object?> get props => [status, user];
}
