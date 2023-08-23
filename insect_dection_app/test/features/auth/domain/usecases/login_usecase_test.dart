import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  late EmailLogin emailLogin;
  late MockAuthRepository mockAuthRepository;

  late AuthenticationParams loginParams;
  late LoginSuccessEntity loginSuccessEntity;

  setUp(() {
    mockAuthRepository = mockAuthRepository = MockAuthRepository();
    emailLogin = EmailLogin(repo: mockAuthRepository);

    loginParams = const AuthenticationParams(
      email: "test_3@gmail.com",
      password: "Pwd12345.",
    );

    loginSuccessEntity = const LoginSuccessEntity(
      token: 'test-token',
      uid: 'test-uid',
      displayName: 'ngtphat',
    );
  });

  group('[Usecase]: Login with email and password', () {
    test('should get [Login Sucess] from repository', () async {
      // arrange
      when(mockAuthRepository.logIn(loginParams))
          .thenAnswer((_) async => Right(loginSuccessEntity));
      // act
      final result = await emailLogin(loginParams);
      // assert
      expect(result, equals(Right(loginSuccessEntity)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockAuthRepository.logIn(any))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await emailLogin(loginParams);
      // assert
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
