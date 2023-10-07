import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

part 'insect_remote_datasources_impl.dart';
part 'user_insect_remote_datasource.dart';

final class InsectCollectionName {
  static String users = 'users';
  static String insects = 'insect_import_test';
  static String bookmarkedInsects = 'favorite_insects';
  static String recentSearches = 'recent_searches';
}

abstract class InsectRemoteDatasource {
  // Get Insect Repository
  Future<Either<Failure, InsectModel>> getInsectByModelId(
    String modelId,
  );
  Future<Either<Failure, InsectListModel>> getInsectByKeyword(String keyword);

  Future<Either<Failure, InsectListModel>> getInitialInsectList(
    InsectListParams insectListParams,
  );
  Future<Either<Failure, InsectListModel>> getMoreInsectList(
    InsectListParams insectListParams,
  );
}

abstract class UserInsectRemoteDatasource {
// Recent search
  Future<Either<Failure, InsectModel>> addRecentlySearchInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectListModel>> getRecentlySearchInsectList(
    UserBucketParams userBucketParams,
    InsectListParams insectListParams,
  );

  // Bookmarked
  Future<Either<Failure, bool>> isBookmarkedInsect(
    UserBucketParams userBucketParams,
    String modelId,
  );
  Future<Either<Failure, InsectModel>> addBookmarkedInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectModel>> removeBookmarkedInsect(
    UserBucketParams userBucketParams,
    InsectParams insectParams,
  );
  Future<Either<Failure, InsectListModel>> getBookmarkedInsectList(
    UserBucketParams userBucketParams,
  );
}
