import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, LoginSuccessEntity>> logIn(
      AuthenticationParams loginParams) async {
    try {
      final loginResponse = await remoteDatasource.logIn(loginParams);

      return Right(loginResponse!.toLoginSucces());
    } on ServerException catch (e) {
      final errorMessage = e.errorMessage;
      return Left(ServerFailure(errorMessage: errorMessage));
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SignUpSuccessEntity>> signUp(
      AuthenticationParams signUpParams) async {
    try {
      final signUpResponse = await remoteDatasource.signUp(signUpParams);

      return Right(signUpResponse!.toSignUpSucces());
    } on ServerException catch (e) {
      final errorMessage = e.errorMessage;
      return Left(ServerFailure(errorMessage: errorMessage));
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      return Right(await remoteDatasource.logOut());
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, AuthUserInfo>> get userInfoState {
    try {
      return remoteDatasource.getUserInfoState.map(
        (userInfo) {
          if (userInfo == null) {
            return Left(AuthenticatedFailure());
          } else {
            return Right(userInfo);
          }
        },
      );
    } on ServerException catch (e) {
      final errorMessage = e.errorMessage;
      return Stream.value(Left(ServerFailure(errorMessage: errorMessage)));
    } catch (e) {
      return Stream.value(Left(UnknownFailure(errorMessage: e.toString())));
    }
  }
}
