import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  group('[Usecase]: Sign up with email and password', () {
    late EmailSignUp emailSignUp;
    late MockAuthRepository mockAuthRepository;

    late AuthenticationParams signUpParams;
    late SignUpSuccessEntity signUpSuccessEntity;

    const tEmail = "test_3@gmail.com";
    const tPasssword = "Pwd12345.";

    const tToken = 'test-token';
    const tUid = 'test-uid';
    setUp(() {
      mockAuthRepository = mockAuthRepository = MockAuthRepository();
      emailSignUp = EmailSignUp(repo: mockAuthRepository);

      signUpParams =
          const AuthenticationParams(email: tEmail, password: tPasssword);
      signUpSuccessEntity = const SignUpSuccessEntity(
        token: tToken,
        uid: tUid,
      );
    });
    test('should get [SignUp Sucess] from repository', () async {
      // arrange
      when(mockAuthRepository.signUp(signUpParams))
          .thenAnswer((_) async => Right(signUpSuccessEntity));
      // act
      final result = await emailSignUp(signUpParams);
      // assert
      verify(mockAuthRepository.signUp(any));
      expect(result, equals(Right(signUpSuccessEntity)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockAuthRepository.signUp(any))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await emailSignUp(signUpParams);
      // assert
      verify(mockAuthRepository.signUp(any));
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
