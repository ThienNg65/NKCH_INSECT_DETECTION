import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/auth/domain/domain.dart';

class SignUpResponse extends Equatable {
  final String uid;
  final String token;
  final String? error;

  const SignUpResponse({
    required this.uid,
    required this.token,
    this.error,
  });
  @override
  List<Object?> get props => [
        uid,
        token,
        error,
      ];

  SignUpSuccessEntity toSignUpSucces() => SignUpSuccessEntity(
        token: token,
        uid: uid,
      );
}
