import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

abstract class InsectRemoteDatasource {
  // Get Insect Repository
  Future<Either<Failure, InsectModel>> getInsectByModelId(
    String modelId,
  );
  Future<Either<Failure, InsectListModel>> getInsectList(
    InsectListParams insectsParams,
  );

  // Recent search
  Future<Either<Failure, InsectModel>> addRecentlySearchInsect(
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectListModel>> getRecentlySearchInsectList(
    InsectListParams insectsParams,
  );

  // Favorite
  Future<Either<Failure, InsectModel>> addFavoriteInsect(
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectModel>> removeFavoriteInsect(
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectListModel>> getFavoriteInsectList(
    InsectListParams insectsParams,
  );
}
