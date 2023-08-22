import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

abstract class InsectRepository {
  // Get Insect Repository
  Future<Either<Failure, Insect>> getInsectByModelId(
    String modelId,
  );
  Future<Either<Failure, InsectList>> getInsectList(
    InsectListParams insectsParams,
  );

  // Recent search
  Future<Either<Failure, Insect>> addRecentlySearchInsect(
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectList>> getRecentlySearchInsectList(
    InsectListParams insectsParams,
  );

  // Favorite
  Future<Either<Failure, Insect>> addFavoriteInsect(
    InsectParams insectParams,
  );
  Future<Either<Failure, Insect>> removeFavoriteInsect(
    InsectParams insectParams,
  );
}
