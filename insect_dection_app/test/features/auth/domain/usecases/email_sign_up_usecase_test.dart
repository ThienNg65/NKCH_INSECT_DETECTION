import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth_domain.mocks.dart';

void main() {
  late EmailSignUp emailSignUp;
  late MockAuthRepository mockAuthRepository;

  late SignUpParams signUpParams;
  late SignUpSuccessEntity signUpSuccessEntity;

  const tEmail = "test_3@gmail.com";
  const tPasssword = "Pwd12345.";

  const tToken = 'test-token';
  const tUid = 'test-uid';
  setUp(() {
    mockAuthRepository = mockAuthRepository = MockAuthRepository();
    emailSignUp = EmailSignUp(mockAuthRepository);

    signUpParams = const SignUpParams(email: tEmail, password: tPasssword);
    signUpSuccessEntity = const SignUpSuccessEntity(
      token: tToken,
      uid: tUid,
    );
  });

  group('Usecase: Test sign up with email and password', () {
    test('Should get [SignUp Sucess] from repository', () async {
      // arrange
      when(mockAuthRepository.signUp(signUpParams))
          .thenAnswer((_) async => Right(signUpSuccessEntity));
      // act
      final result = await emailSignUp(signUpParams);
      // assert
      expect(result, equals(Right(signUpSuccessEntity)));
    });
    test('Should get [Failure] from repository', () async {
      // arrange
      when(mockAuthRepository.signUp(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await emailSignUp(signUpParams);
      // assert
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
