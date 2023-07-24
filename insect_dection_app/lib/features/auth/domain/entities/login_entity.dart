import 'package:equatable/equatable.dart';

class LoginSuccessEntity extends Equatable {
  final String token;
  final String uid;
  final String displayName;

  const LoginSuccessEntity({
    required this.token,
    required this.uid,
    required this.displayName,
  });

  @override
  List<Object?> get props => [token, uid, displayName];
}
