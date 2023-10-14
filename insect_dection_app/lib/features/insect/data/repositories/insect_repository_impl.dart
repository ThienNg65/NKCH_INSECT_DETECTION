import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectRepositoryImpl extends InsectRepository {
  final InsectRemoteDatasource _remoteDatasource;

  InsectRepositoryImpl({required InsectRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, Insect>> getInsectByModelId(String modelId) async {
    final response = await _remoteDatasource.getInsectByModelId(modelId);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectModel model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getInitialInsectList(
      InsectListParams insectListParams) async {
    final response =
        await _remoteDatasource.getInitialInsectList(insectListParams);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getMoreInsectList(
      InsectListParams insectListParams) async {
    final response =
        await _remoteDatasource.getMoreInsectList(insectListParams);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getInsectByKeyword(
      InsectListFilterParams insectListFilterParams) async {
    final response =
        await _remoteDatasource.getInsectByKeyword(insectListFilterParams);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }

  @override
  Future<Either<Failure, InsectList>> getInsectsByTaxnomyRank(
      InsectListFilterParams insectListFilterParams) async {
    final response =
        await _remoteDatasource.getInsectsByTaxnomyRank(insectListFilterParams);
    return response.fold(
      (Failure failure) => Left(failure),
      (InsectListModel models) => Right(models.toEntity()),
    );
  }
}
