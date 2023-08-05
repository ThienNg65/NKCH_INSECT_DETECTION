import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  late GetCurrentAuthUserInfoStream usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentAuthUserInfoStream(
      repo: mockAuthRepository,
    );
  });

  const tAuthUserInfo = AuthUserInfo(
    uid: 'uid',
    displayName: 'displayName',
    email: 'email',
    phoneNumber: 'phoneNumber',
    photoUrl: 'photoUrl',
  ); // fill in the details

  const errorMessage = 'errorMessage';
  const failure = ServerFailure(errorMessage: errorMessage);
  test(
    'should get [AuthUserInfo] state from the repository',
    () async {
      // arrange
      when(mockAuthRepository.userInfoState)
          .thenAnswer((_) => Stream.value(const Right(tAuthUserInfo)));
      // act
      final result = usecase(NoParams());
      // assert
      expectLater(result, emits(const Right(tAuthUserInfo)));
      verify(mockAuthRepository.userInfoState);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
  test(
    'should get [Failure]  state from the repository',
    () async {
      // arrange
      when(mockAuthRepository.userInfoState)
          .thenAnswer((_) => Stream.value(const Left(failure)));
      // act
      final result = usecase(NoParams());
      // assert
      expectLater(result, emits(const Left(failure)));
      verify(mockAuthRepository.userInfoState);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
