import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/error/failure.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectRepositoryImpl extends InsectRepository {
  final InsectRemoteDatasource _remoteDatasource;

  InsectRepositoryImpl({required InsectRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, Insect>> addFavoriteInsect(
      InsectParams insectParams) async {
    final response =
        await _remoteDatasource.addRecentlySearchInsect(insectParams);
    return response.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Insect>> addRecentlySearchInsect(
      InsectParams insectParams) async {
    final response =
        await _remoteDatasource.addRecentlySearchInsect(insectParams);
    return response.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Insect>> getInsectByModelId(String modelId) async {
    final response = await _remoteDatasource.getInsectByModelId(modelId);
    return response.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getInsectList(
      InsectListParams insectsParams) async {
    final response = await _remoteDatasource.getInsectList(insectsParams);
    return response.fold(
      (failure) => Left(failure),
      (models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getRecentlySearchInsectList(
      InsectListParams insectsParams) async {
    final response =
        await _remoteDatasource.getRecentlySearchInsectList(insectsParams);
    return response.fold(
      (failure) => Left(failure),
      (models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Insect>> removeFavoriteInsect(
      InsectParams insectParams) async {
    final response =
        await _remoteDatasource.removeFavoriteInsect(insectParams);
    return response.fold(
      (failure) => Left(failure),
      (models) => Right(models.toEntity()),
    );
  }
}
