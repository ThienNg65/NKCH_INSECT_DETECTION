part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? message;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.message,
  });
  // This is for mannual testing only
  factory LoginState.initial() => const LoginState(
        email: 'nvtt@gmail.com',
        password: '12345678',
        status: LoginStatus.initial,
        message: '',
      );

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        message,
      ];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
