import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth_domain.mocks.dart';

void main() {
  late EmailLogin emailLogin;
  late MockAuthRepository mockAuthRepository;

  late LoginParams loginParams;
  late LoginSuccessEntity loginSuccessEntity;

  const tEmail = "test_3@gmail.com";
  const tPasssword = "Pwd12345.";

  const tToken = 'test-token';
  const tDisplayName = 'ngtphat';
  const tUid = 'test-uid';
  setUp(() {
    mockAuthRepository = mockAuthRepository = MockAuthRepository();
    emailLogin = EmailLogin(mockAuthRepository);

    loginParams = const LoginParams(email: tEmail, password: tPasssword);
    loginSuccessEntity = const LoginSuccessEntity(
      token: tToken,
      uid: tUid,
      displayName: tDisplayName,
    );
  });

  group('Usecase: Test login with email and password', () {
    test('Should get [Login Sucess] from repository', () async {
      // arrange
      when(mockAuthRepository.logIn(loginParams))
          .thenAnswer((_) async => Right(loginSuccessEntity));
      // act
      final result = await emailLogin(loginParams);
      // assert
      expect(result, equals(Right(loginSuccessEntity)));
    });
    test('Should get [Failure] from repository', () async {
      // arrange
      when(mockAuthRepository.logIn(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await emailLogin(loginParams);
      // assert
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
