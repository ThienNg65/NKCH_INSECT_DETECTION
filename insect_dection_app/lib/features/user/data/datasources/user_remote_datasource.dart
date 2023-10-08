import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/features/user/user.dart';

abstract class UserProfileRemoteDataSource {
  Future<Either<Failure, UserProfileModel>> getUserProfile(
      UserParams userParams);
  Future<Either<Failure, UserProfileModel>> createUserProfile(
      UserParams userParams);
  Future<Either<Failure, UserProfileModel>> updateUserProfile(
      UserParams userParams);
  Future<Either<Failure, List<UserProfileModel>>> getUserProfileList();
}

class UserProfileRemoteDatasourceImpl extends UserProfileRemoteDataSource {
  final FirebaseFirestore _database;

  UserProfileRemoteDatasourceImpl({
    required FirebaseFirestore? database,
  }) : _database = database ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserProfileModel>> createUserProfile(
      UserParams userParams) async {
    try {
      // Create a document in the users collection with the user's data.
      await _database.collection('users').doc(userParams.uid).set(
            userParams.toMap(),
          );
      await _database
          .collection('users')
          .doc(userParams.uid)
          .collection(InsectCollectionName.bookmarkedInsects)
          .add({});
      await _database
          .collection('users')
          .doc(userParams.uid)
          .collection(InsectCollectionName.recentSearches)
          .add({});

      // Create a UserProfileModel from the document data.
      final userProfileModel = UserProfileModel.fromMap(userParams.toMap());

      return Right(userProfileModel);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile(
      UserParams userParams) async {
    try {
      // Get the document from Firestore.
      final document =
          await _database.collection('users').doc(userParams.uid).get();

      // Check if the document exists.
      if (!document.exists) {
        return const Left(UserNotFoundFailure());
      }
      // Take data from document
      final data = document.data()!;

      // Create a UserProfileModel from the document data.
      final userProfileModel = UserProfileModel.fromMap(data);

      // Return the user profile model.
      return Right(userProfileModel);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<UserProfileModel>>> getUserProfileList() async {
    try {
      // Get the query from Firestore.
      final query = FirebaseFirestore.instance.collection('users');

      // Get the results of the query.
      final results = await query.get();

      // Create a list of UserProfileModels from the results.
      final userProfileModels = results.docs.map((doc) {
        return UserProfileModel.fromMap(doc.data());
      }).toList();

      // Return the list of UserProfileModels.
      return Right(userProfileModels);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  /// The `userProfile` parameter is a `UserParams` object that contains
  /// the data that we want to update in the user profile document.
  ///
  /// The function returns an `Either` object. The `Either` object can either
  /// contain a `UserProfileModel` object or a `Failure` object.
  @override
  Future<Either<Failure, UserProfileModel>> updateUserProfile(
      UserParams userParams) async {
    // The `uid` field is the unique identifier for the user.
    final uid = userParams.uid;

    // Check to make sure that the `uid` field is not null.
    // If the `uid` field is null, then we return an `InvalidInputFailure` error.
    if (uid == null) {
      return const Left(InvalidInputFailure(errorMessage: 'uid is required'));
    }

    // Create a `UserProfileModel` object from the `UserParams` object.
    final userProfileModel = UserProfileModel.fromUserParams(userParams);

    // Try to update the user profile document in Firestore.
    try {
      await _database
          .collection('users')
          .doc(uid)
          .update(userProfileModel.toMap());

      // Return the user profile model.
      return Right(userProfileModel);
    } on FirebaseException catch (e) {
      // If the update is not successful, then we return a `Left` object
      // containing a `ServerFailure` object.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }
}
