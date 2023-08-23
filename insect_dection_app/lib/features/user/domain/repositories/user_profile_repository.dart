import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile(
    UserParams userParams,
  );
  Future<Either<Failure, UserProfileEntity>> createUserProfile(
    UserParams userParams,
  );
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(
   UserParams userParams
  );
  Future<Either<Failure, List<UserProfileEntity>>> getUserProfileList();
}
