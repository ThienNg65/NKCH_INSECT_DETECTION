import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, LoginSuccessEntity>> logIn(
      LoginParams loginParams) async {
    try {
      final loginResponse = await remoteDatasource.logIn(loginParams);

      return Right(loginResponse!.toLoginSucces());
    } on ServerException catch (e) {
      final errorMessage = e.errorMesage;
      return Left(ServerFailure(errorMessage: errorMessage));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SignUpSuccessEntity>> signUp(
      SignUpParams signUpParams) async {
    try {
      final signUpResponse = await remoteDatasource.signUp(signUpParams);

      return Right(signUpResponse!.toSignUpSucces());
    } on ServerException catch (e) {
      final errorMessage = e.errorMesage;
      return Left(ServerFailure(errorMessage: errorMessage));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
