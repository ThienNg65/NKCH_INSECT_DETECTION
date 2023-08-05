import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/auth/domain/domain.dart';

class LoginResponse extends Equatable {
  final String uid;
  final String? token;
  final String? displayName;
  final String? error;

  const LoginResponse({
    required this.uid,
    this.token,
    this.displayName,
    this.error,
  });
  @override
  List<Object?> get props => [
        uid,
        token,
        displayName,
        error,
      ];

  LoginSuccessEntity toLoginSucces() => LoginSuccessEntity(
        token: token ?? '',
        uid: uid,
        displayName: displayName ?? '',
      );
}
