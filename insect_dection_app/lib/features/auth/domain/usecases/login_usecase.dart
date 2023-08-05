import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class EmailLogin extends UseCase<LoginSuccessEntity, AuthenticationParams> {
  final AuthRepository _repo;

  EmailLogin({required AuthRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, LoginSuccessEntity>> call(
          AuthenticationParams params) =>
      _repo.logIn(params);
}
