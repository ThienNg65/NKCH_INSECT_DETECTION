import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/user/user_domain.mocks.dart';

void main() {
  late UserProfileBloc userProfileBloc;
  late MockGetUserProfile mockGetUserProfile;
  late MockUpdateUserProfile mockUpdateUserProfile;

  const uid = 'testUid';
  const username = 'nvtt@gmail.com';
  const userProfileEntity = UserProfileEntity(
    uid: uid,
    username: username,
    phoneNumber: '0922245136',
    firstName: 'Insect',
    lastName: 'Dection',
    address: Address(
      street: '3/2 Street',
      city: 'Cantho',
      country: 'Vietnam',
    ),
    photoUrl: 'https://examples.com/testUid/avatar.jpg',
  );
  // const userParams =  UserParams(
  //       uid: 'testUid',
  //       username: 'nvtt@gmail.com',
  //       phoneNumber: '0922245136',
  //       firstName: 'Insect',
  //       lastName: 'Dection',
  //       address: Address(
  //         street: '3/2 Street',
  //         city: 'Cantho',
  //         country: 'Vietnam',
  //       ),
  //       photoUrl: 'https://examples.com/testUid/avatar.jpg',
  //     );
  setUp(() {
    mockGetUserProfile = MockGetUserProfile();
    mockUpdateUserProfile = MockUpdateUserProfile();

    userProfileBloc = UserProfileBloc(
      getUserProfile: mockGetUserProfile,
      updateUserProfile: mockUpdateUserProfile,
    );
  });

  // Dispose bloc
  tearDown(() {
    userProfileBloc.close();
  });

  test('initial statua is [initial]', () async {
    expect(userProfileBloc.state, equals(UserProfileState.initial()));
  });
  group('[OnLoadUserProfileEvent]', () {
    blocTest<UserProfileBloc, UserProfileState>(
      'should emit [Loading, Success] when the usecase called successfully',
      build: () {
        when(mockGetUserProfile.call(any))
            .thenAnswer((_) async => const Right(userProfileEntity));
        return userProfileBloc;
      },
      act: (bloc) => bloc.add(OnLoadUserProfileEvent(
        uid: uid,
        username: username,
      )),
      expect: () => <UserProfileState>[
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.loading,
        ),
        UserProfileState.initial().fromEntity(entity: userProfileEntity),
      ],
    );
    blocTest<UserProfileBloc, UserProfileState>(
      'should emit [Loading, Error] when the called of use case fails',
      build: () {
        when(mockGetUserProfile.call(any))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return userProfileBloc;
      },
      act: (bloc) => bloc.add(OnLoadUserProfileEvent(
        uid: uid,
        username: username,
      )),
      expect: () => <UserProfileState>[
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.loading,
        ),
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.error,
          message: 'Something wrong occurs to server!',
        )
      ],
    );
  });
  group('[UpdateUserProfileEvent]', () {
    blocTest<UserProfileBloc, UserProfileState>(
      'should emit [Loading, Success] when the usecase called successfully',
      build: () {
        when(mockUpdateUserProfile.call(any)).thenAnswer(
          (_) async => Right(
            userProfileEntity.copyWith(
              firstName: 'New first name',
            ),
          ),
        );
        return userProfileBloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        felid: 'firstName',
        value: 'New first name',
      )),
      expect: () => <UserProfileState>[
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.loading,
        ),
        UserProfileState.initial().fromEntity(
          entity: userProfileEntity.copyWith(firstName: 'New first name'),
        ),
      ],
    );
    blocTest<UserProfileBloc, UserProfileState>(
      'should emit [Loading, Error] when the called of use case fails',
      build: () {
        when(mockUpdateUserProfile.call(any))
            .thenAnswer((_) async => const Left(ServerFailure()));
        return userProfileBloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        felid: uid,
        value: username,
      )),
      expect: () => <UserProfileState>[
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.loading,
        ),
        UserProfileState.initial().copyWith(
          status: UserProfileStatus.error,
          message: 'Something wrong occurs to server!',
        )
      ],
    );
  });
}
