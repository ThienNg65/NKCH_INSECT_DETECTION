import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/user/user_domain.mocks.dart';

void main() {
  late UpdateUserProfile updateUserProfile;
  late MockUserProfileRepository mockUserRepository;

  late UserParams userParams;
  late UserProfileEntity userProfileEnity;

  setUp(() {
    mockUserRepository = mockUserRepository = MockUserProfileRepository();
    updateUserProfile = UpdateUserProfile(repo: mockUserRepository);

    userParams = const UserParams(
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

    userProfileEnity = const UserProfileEntity(
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
  });

  group('[Usecase]: Get user profile', () {
    test('should get [UserProfileEnity] from repository', () async {
      // arrange
      when(mockUserRepository.updateUserProfile(userParams))
          .thenAnswer((_) async => Right(userProfileEnity));
      // act
      final result = await updateUserProfile(userParams);
      // assert
      verify(mockUserRepository.updateUserProfile(userParams));
      expect(result, equals(Right(userProfileEnity)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockUserRepository.updateUserProfile(userParams))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await updateUserProfile(userParams);
      // assert
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
