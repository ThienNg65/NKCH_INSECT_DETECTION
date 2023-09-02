import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class UserInsectDataRepositoryImpl extends UserInsectDataRepository {
  final UserInsectRemoteDatasource _remoteDatasource;

  UserInsectDataRepositoryImpl(
      {required UserInsectRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, Insect>> addBookmarkedInsect(
      UserBucketParams userBucketParams, InsectParams insectParams) async {
    final response = await _remoteDatasource.addBookmarkedInsect(
      userBucketParams,
      insectParams,
    );
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectModel model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Insect>> addRecentlySearchInsect(
      UserBucketParams userBucketParams, InsectParams insectParams) async {
    final response = await _remoteDatasource.addRecentlySearchInsect(
      userBucketParams,
      insectParams,
    );
    return response.fold(
      (failure) => Left(failure),
      (InsectModel model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getBookmarkedInsectList(
      UserBucketParams userBucketParams) async {
    final response =
        await _remoteDatasource.getBookmarkedInsectList(userBucketParams);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getRecentlySearchInsectList(
    UserBucketParams userBucketParams,
    InsectListParams insectListParams,
  ) async {
    final response = await _remoteDatasource.getRecentlySearchInsectList(
      userBucketParams,
      insectListParams,
    );
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Insect>> removeBookmarkedInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  ) async {
    final response = await _remoteDatasource.removeBookmarkedInsect(
      userBucketParams,
      insectParams,
    );
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectModel model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, bool>> isBookmarkedInsect(
    UserBucketParams userBucketParams,
    String modelId,
  ) async {
    final response = await _remoteDatasource.isBookmarkedInsect(
      userBucketParams,
      modelId,
    );
    return response.fold(
      (Failure failure) => Left(failure),
      (bool isExit) => Right(isExit),
    );
  }
}
