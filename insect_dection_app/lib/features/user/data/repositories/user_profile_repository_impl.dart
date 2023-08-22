import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';

class UserProfileRepositoryImpl extends UserProfileRepository {
  final UserProfileRemoteDataSource _remoteDataSource;

  UserProfileRepositoryImpl({
    required UserProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  // TODO: should create instance of userdata in local
  @override
  Future<Either<Failure, UserProfileEntity>> createUserProfile(
      UserParams userParams) async {
    final remoteRespone = await _remoteDataSource.createUserProfile(userParams);
    return remoteRespone.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile(
      UserParams userParams) async {
    final remoteRespone = await _remoteDataSource.getUserProfile(userParams);
    return remoteRespone.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<UserProfileEntity>>> getUserProfileList() async {
    final remoteRespone = await _remoteDataSource.getUserProfileList();
    return remoteRespone.fold(
      (Failure failure) => Left(failure),
      (models) {
        final entities = models.map((e) => e.toEntity()).toList();
        return Right(entities);
      },
    );
  }

  // TODO: should create instance of userdata in local
  @override
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(
      UserParams userParams) async {
    final remoteRespone = await _remoteDataSource.updateUserProfile(userParams);
    return remoteRespone.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}
