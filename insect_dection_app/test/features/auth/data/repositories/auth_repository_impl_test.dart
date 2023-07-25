import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth_domain.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDatasource mockRemoteDatasource;

  late LoginParams loginParams;
  late LoginResponse loginResponse;
  late LoginSuccessEntity loginSuccess;

  late SignUpParams signUpParams;
  late SignUpResponse signUpResponse;
  late SignUpSuccessEntity signUpSuccess;

  setUp(() {
    mockRemoteDatasource = MockAuthRemoteDatasource();
    authRepository = AuthRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
    );
  });

  group('[Authentication Repository] Login with email and password', () {
    loginParams = const LoginParams(
      email: 'test.email@example.com',
      password: 'Pwd12345.',
    );
    loginResponse = const LoginResponse(
      uid: 'test-uid',
      token: 'test-token',
      displayName: 'test-displayName',
    );
    loginSuccess = const LoginSuccessEntity(
      token: 'test-token',
      uid: 'test-uid',
      displayName: 'test-displayName',
    );
    test('Should return [Login Success] when call remote data is successfully',
        () async {
      // arrange
      when(mockRemoteDatasource.logIn(loginParams))
          .thenAnswer((_) async => loginResponse);
      // act
      final result = await authRepository.logIn(loginParams);
      //assert
      verify(mockRemoteDatasource.logIn(loginParams));
      expect(result, equals(Right(loginSuccess)));
    });
    test(
        'Should return [Server Failure] when calling remote data is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDatasource.logIn(loginParams))
          .thenThrow(ServerException());
      // act
      final result = await authRepository.logIn(loginParams);
      //assert
      verify(mockRemoteDatasource.logIn(loginParams));
      expect(result, equals(const Left(ServerFailure())));
    });
  });
  group('[Authentication Repository] Sign up with email and password', () {
    signUpParams = const SignUpParams(
      email: 'test.email@example.com',
      password: 'Pwd12345.',
    );
    signUpResponse = const SignUpResponse(
      uid: 'test-uid',
      token: 'test-token',
    );
    signUpSuccess = const SignUpSuccessEntity(
      token: 'test-token',
      uid: 'test-uid',
    );
    test(
        'Should return [SignUp Success] when calling remote data is successfull',
        () async {
      //arrange
      when(mockRemoteDatasource.signUp(signUpParams))
          .thenAnswer((_) async => signUpResponse);
      // act
      final result = await authRepository.signUp(signUpParams);
      // assert
      verify(mockRemoteDatasource.signUp(signUpParams));
      expect(result, equals(Right(signUpSuccess)));
    });
    test(
        'Should return [Failure] when calling remote data base throws [ServerException]',
        () async {
      // arrange
      when(mockRemoteDatasource.signUp(signUpParams))
          .thenThrow((_) => ServerException());
      // act
      final result = await authRepository.signUp(signUpParams);
      // assert
      verify(mockRemoteDatasource.signUp(signUpParams));
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
