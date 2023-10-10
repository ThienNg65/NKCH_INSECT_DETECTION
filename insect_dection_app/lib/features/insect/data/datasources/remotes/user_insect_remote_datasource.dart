part of 'insect_remote_datasources.dart';

class UserInsectRemoteDatasourceImpl implements UserInsectRemoteDatasource {
  final FirebaseFirestore _data;

  UserInsectRemoteDatasourceImpl({
    required FirebaseFirestore data,
    required FirebaseStorage storage,
  }) : _data = data;

  @override
  Future<Either<Failure, InsectModel>> addBookmarkedInsect(
      UserBucketParams userBucketParams, InsectParams insectParams) async {
    try {
      // convert model from params
      final model = InsectModel.fromParams(insectParams);

      /// Add new document into the favoirite insect
      /// under the users' profile bucket in firebase
      await _data
          // User profile
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          // Subcollection Insect
          .collection(InsectCollectionName.bookmarkedInsects)
          .doc(insectParams.modelId)
          .set(model.toMap());

      /// Return the value if adding was succesfully
      return Right(model);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, InsectModel>> addRecentlySearchInsect(
      UserBucketParams userBucketParams, InsectParams insectParams) async {
    try {
      // convert model from params
      final model = InsectModel.fromParams(insectParams);

      /// Add new document into the favoirite insect
      /// under the users' profile bucket in firebase
      await _data
          // User profile
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          // Subcollection Insect
          .collection(InsectCollectionName.recentSearches)
          .doc(insectParams.modelId)
          .set(model.toMap());

      /// Return the value if adding was succesfully
      return Right(model);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getBookmarkedInsectList(
      UserBucketParams userBucketParams) async {
    try {
      /// Add new document into the favoirite insect
      /// under the users' profile bucket in firebase
      final snapshot = await _data
          // User profile
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          // Subcollection Insect
          .collection(InsectCollectionName.bookmarkedInsects)
          .get();

      /// Convert query snapshot into list
      final insects = snapshot.docs
          .map(
            (doc) => InsectModel.fromMap(doc.data()),
          )
          .toList();

      /// Assign into model
      final insectList = InsectListModel(
        currentPage: insects,
        size: insects.length,
      );

      /// Return the value if adding was succesfully
      return Right(insectList);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getRecentlySearchInsectList(
      UserBucketParams userBucketParams,
      InsectListParams insectListParams) async {
    try {
      // Get snapshot data of the fixed number of insect.
      final insectsSnapshot = await _data
          // User Profile
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          // Recently Search
          .collection(InsectCollectionName.recentSearches)
          // Sort by model id and take fixed number of insects
          .orderBy('modelId', descending: true)
          .limit(insectListParams.size)
          .get();

      final insects = insectsSnapshot.docs
          .map((doc) => InsectModel.fromMap(doc.data()))
          .toList();

      return Right(InsectListModel(
        size: insects.length,
        currentPage: insects,
      ));
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, InsectModel>> removeBookmarkedInsect(
      UserBucketParams userBucketParams, InsectParams insectParams) async {
    try {
      // convert model from params
      final model = InsectModel.fromParams(insectParams);

      /// Add new document into the favoirite insect
      /// under the users' profile bucket in firebase
      await _data
          // User profile
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          // Subcollection Insect
          .collection(InsectCollectionName.bookmarkedInsects)
          .doc(insectParams.modelId)
          .delete();

      /// Return the value if adding was succesfully
      return Right(model);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarkedInsect(
    UserBucketParams userBucketParams,
    String modelId,
  ) async {
    try {
      final doc = await _data
          .collection(InsectCollectionName.users)
          .doc(userBucketParams.uid)
          .collection(InsectCollectionName.bookmarkedInsects)
          .doc(modelId)
          .get();
      final isExit = doc.exists;
      return Right(isExit);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    } catch (err) {
      return Left(InternalFailure(
        errorMessage: err.toString(),
      ));
    }
  }
}
