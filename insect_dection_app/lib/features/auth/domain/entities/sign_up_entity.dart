import 'package:equatable/equatable.dart';

class SignUpSuccessEntity extends Equatable {
  final String? token;
  final String uid;

  const SignUpSuccessEntity({
    this.token,
    required this.uid,
  });

  @override
  List<Object?> get props => [
        token,
        uid,
      ];
}
