import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/user/user_domain.mocks.dart';

void main() {
  late GetUserProfileList getUserProfiles;
  late MockUserProfileRepository mockUserRepository;

  late List<UserProfileEntity> userProfiles;

  setUp(() {
    mockUserRepository = mockUserRepository = MockUserProfileRepository();
    getUserProfiles = GetUserProfileList(repo: mockUserRepository);

    userProfiles = [
      const UserProfileEntity(
        /// Account Identity
        uid: "test_2@-uid",
        username: "nvtt@gmail.com",
        phoneNumber: "0922245136",
        photoUrl: "https://examples.com/test_2@-uid/avatar.jpg",
      ),
      const UserProfileEntity(
        /// Account Identity
        uid: "test_2@-uid",
        username: "nvtt@gmail.com",
        phoneNumber: "0922245136",
        photoUrl: "https://examples.com/test_3@-uid/avatar.jpg",
      ),
      const UserProfileEntity(
        /// Account Identity
        uid: "test_3@-uid",
        username: "nvtt@gmail.com",
        phoneNumber: "0922245136",
        photoUrl: "https://examples.com/test_3@-uid/avatar.jpg",
      )
    ];
  });

  group('[Usecase]: Get User Profile List', () {
    test('should get [Login Sucess] from repository', () async {
      // arrange
      when(mockUserRepository.getUserProfileList())
          .thenAnswer((_) async => Right(userProfiles));
      // act
      final result = await getUserProfiles(NoParams());
      // assert
      verify(mockUserRepository.getUserProfileList());
      expect(result, equals(Right(userProfiles)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockUserRepository.getUserProfileList())
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await getUserProfiles(NoParams());
      // assert
      verify(mockUserRepository.getUserProfileList());
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
