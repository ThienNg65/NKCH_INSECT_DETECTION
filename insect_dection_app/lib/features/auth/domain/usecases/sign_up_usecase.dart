import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class EmailSignUp extends UseCase<SignUpSuccessEntity, AuthenticationParams> {
  final AuthRepository _repo;

  EmailSignUp({required AuthRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, SignUpSuccessEntity>> call(
          AuthenticationParams params) =>
      _repo.signUp(params);
}
