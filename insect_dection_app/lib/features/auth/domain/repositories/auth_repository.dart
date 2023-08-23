import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';


abstract class AuthRepository {
  Stream<Either<Failure, AuthUserInfo>> get userInfoState;

  Future<Either<Failure, LoginSuccessEntity>> logIn(
      AuthenticationParams loginParams);

  Future<Either<Failure, SignUpSuccessEntity>> signUp(
      AuthenticationParams signUpParams);
  Future<Either<Failure, void>> logOut();
}
