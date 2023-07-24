import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginSuccessEntity>> logIn(LoginParams loginParams);

  Future<Either<Failure, SignUpSuccessEntity>> signUp(
      SignUpParams registerParams);
}
