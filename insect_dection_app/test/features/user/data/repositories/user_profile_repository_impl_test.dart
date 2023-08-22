import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/user/user_domain.mocks.dart';

void main() {
  late UserProfileRepositoryImpl repository;
  late MockUserProfileRemoteDataSource mockRemoteDataSource;

  late UserParams userParams;
  late UserProfileModel userProfileModel;
  late UserProfileEntity userProfileEntity;

  setUp(() {
    mockRemoteDataSource = MockUserProfileRemoteDataSource();
    repository = UserProfileRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );

    userParams = const UserParams(
      uid: "test_3@-uid",
      username: 'test@gmail.com',
    );
    userProfileModel = const UserProfileModel(
      /// Account Identity
      uid: "test_3@-uid",
      username: "nvtt@gmail.com",
      phoneNumber: "0922245136",

      /// User'Information
      firstName: "Insect",
      lastName: "Dection",

      /// Others
      address: Address(
        city: "Cantho",
        country: "3/2 Street",
        street: "3/2 Street",
      ),
      photoUrl: "https://examples.com/test_3@-uid/avatar.jpg",
    );
    userProfileEntity = userProfileModel.toEntity();
  });
  group('[User Profile Repository]', () {
    group('Create user profile', () {
      test(
          'should return [UserProfileEntity] when the call to remote data source is successful',
          () async {
        /// Arrange
        when(mockRemoteDataSource.createUserProfile(userParams))
            .thenAnswer((_) async => Right(userProfileModel));

        /// Act
        final result = await repository.createUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.createUserProfile(any));
        expect(result, equals(Right(userProfileEntity)));
      });
      test(
          'should return [Failure] when the call to remote data source is fail',
          () async {
        /// Arrange
        when(mockRemoteDataSource.createUserProfile(userParams))
            .thenAnswer((_) async => const Left(ServerFailure()));

        /// Act
        final result = await repository.createUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.createUserProfile(any));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Get User Profile', () {
      test(
          'should return [UserProfileEntity] when the call to remote data source is successful',
          () async {
        /// Arrange
        when(mockRemoteDataSource.getUserProfile(userParams))
            .thenAnswer((_) async => Right(userProfileModel));

        /// Act
        final result = await repository.getUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.getUserProfile(any));
        expect(result, equals(Right(userProfileEntity)));
      });
      test(
          'should return [Failure] when the call to remote data source is fail',
          () async {
        /// Arrange
        when(mockRemoteDataSource.getUserProfile(userParams))
            .thenAnswer((_) async => const Left(ServerFailure()));

        /// Act
        final result = await repository.getUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.getUserProfile(any));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Get User Profile List', () {
      final mockUserProfileModels = [
        const UserProfileModel(
          /// Account Identity
          uid: "test_2@-uid",
          username: "nvtt@gmail.com",
          phoneNumber: "0922245136",
          photoUrl: "https://examples.com/test_2@-uid/avatar.jpg",
        ),
        const UserProfileModel(
          /// Account Identity
          uid: "test_3@-uid",
          username: "nvtt@gmail.com",
          phoneNumber: "0922245136",
          photoUrl: "https://examples.com/test_3@-uid/avatar.jpg",
        )
      ];
      final mockUserProfileEntities =
          mockUserProfileModels.map((model) => model.toEntity()).toList();
      test(
          'should return List of [UserProfileEntity] when the call to remote data source is successful',
          () async {
        /// Arrange
        when(mockRemoteDataSource.getUserProfileList())
            .thenAnswer((_) async => Right(mockUserProfileModels));

        /// Act
        final result = await repository.getUserProfileList();

        /// Asssert
        verify(mockRemoteDataSource.getUserProfileList());
        expect(result, equals(Right(mockUserProfileEntities)));
      });
      test(
          'should return [Failure] when the call to remote data source is fail',
          () async {
        /// Arrange
        when(mockRemoteDataSource.getUserProfileList())
            .thenAnswer((_) async => const Left(ServerFailure()));

        /// Act
        final result = await repository.getUserProfileList();

        /// Asssert
        verify(mockRemoteDataSource.getUserProfileList());
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Update User Profile', () {
      test(
          'should return [UserProfileEntity] when the call to remote data source is successful',
          () async {
        /// Arrange
        when(mockRemoteDataSource.updateUserProfile(userParams))
            .thenAnswer((_) async => Right(userProfileModel));

        /// Act
        final result = await repository.updateUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.updateUserProfile(any));
        expect(result, equals(Right(userProfileEntity)));
      });
      test(
          'should return [Failure] when the call to remote data source is fail',
          () async {
        /// Arrange
        when(mockRemoteDataSource.updateUserProfile(userParams))
            .thenAnswer((_) async => const Left(ServerFailure()));

        /// Act
        final result = await repository.updateUserProfile(userParams);

        /// Asssert
        verify(mockRemoteDataSource.updateUserProfile(any));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
  });
}
