import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

abstract class InsectRepository {
  // Get Insect Repository
  Future<Either<Failure, Insect>> getInsectByModelId(
    String modelId,
  );
  Future<Either<Failure, InsectList>> getInsectByKeyword(
    InsectListFilterParams insectListFilterParams,
  );
  Future<Either<Failure, InsectList>> getInitialInsectList(
    InsectListParams insectListParams,
  );
  Future<Either<Failure, InsectList>> getMoreInsectList(
    InsectListParams insectListParams,
  );
}

abstract class UserInsectDataRepository {
  // Recent search
  Future<Either<Failure, Insect>> addRecentlySearchInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectList>> getRecentlySearchInsectList(
    UserBucketParams userBucketParams,
    InsectListParams insectListParams,
  );

  // Bookmarked
  Future<Either<Failure, bool>> isBookmarkedInsect(
    UserBucketParams userBucketParams,
    String modelId,
  );
  Future<Either<Failure, Insect>> addBookmarkedInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, Insect>> removeBookmarkedInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectList>> getBookmarkedInsectList(
    UserBucketParams userBucketParams,
  );
}
