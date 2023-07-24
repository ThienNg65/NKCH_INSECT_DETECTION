import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class EmailSignUp extends UseCase<SignUpSuccessEntity, SignUpParams> {
  final AuthRepository _repo;

  EmailSignUp(this._repo);

  @override
  Future<Either<Failure, SignUpSuccessEntity>> call(SignUpParams params) =>
      _repo.signUp(params);
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  const SignUpParams({
    this.email = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [email, password];
}
