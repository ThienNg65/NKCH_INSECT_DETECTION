import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class EmailLogin extends UseCase<LoginSuccessEntity, LoginParams> {
  final AuthRepository _repo;

  EmailLogin(this._repo);

  @override
  Future<Either<Failure, LoginSuccessEntity>> call(LoginParams params) =>
      _repo.logIn(params);
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  const LoginParams({
    this.email = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [email, password];
}
