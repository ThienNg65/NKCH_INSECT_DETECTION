// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { intial, loading, success, error }

class SignUpState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final SignUpStatus status;
  final String? message;

  const SignUpState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.status,
    required this.message,
  });
  factory SignUpState.initial() => const SignUpState(
        email: '',
        password: '',
        confirmPassword: '',
        status: SignUpStatus.intial,
        message: '',
      );
  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        status,
        message,
      ];

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    SignUpStatus? status,
    String? message,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
