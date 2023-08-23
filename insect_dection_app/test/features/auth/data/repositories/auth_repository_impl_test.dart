import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

import 'package:mockito/mockito.dart';

import '../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  group('[Authentication Repository]', () {
    late AuthRepositoryImpl authRepository;
    late MockAuthRemoteDatasource mockRemoteDatasource;

    late AuthenticationParams authParams;

    late LoginResponse loginResponse;
    late LoginSuccessEntity loginSuccess;

    late SignUpResponse signUpResponse;
    late SignUpSuccessEntity signUpSuccess;

    setUp(() {
      mockRemoteDatasource = MockAuthRemoteDatasource();
      authRepository = AuthRepositoryImpl(
        remoteDatasource: mockRemoteDatasource,
      );
    });

    group('Login with email and password', () {
      authParams = const AuthenticationParams(
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
      test(
          'should return [Login Success] when call remote data is successfully',
          () async {
        // arrange
        when(mockRemoteDatasource.logIn(authParams))
            .thenAnswer((_) async => loginResponse);
        // act
        final result = await authRepository.logIn(authParams);
        //assert
        verify(mockRemoteDatasource.logIn(authParams));
        expect(result, equals(Right(loginSuccess)));
      });
      test(
          'should return [Server Failure] when calling remote data is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDatasource.logIn(authParams))
            .thenThrow(ServerException());
        // act
        final result = await authRepository.logIn(authParams);
        //assert
        verify(mockRemoteDatasource.logIn(authParams));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Sign up with email and password', () {
      authParams = const AuthenticationParams(
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
          'should return [SignUp Success] when calling remote data is successfull',
          () async {
        //arrange
        when(mockRemoteDatasource.signUp(authParams))
            .thenAnswer((_) async => signUpResponse);
        // act
        final result = await authRepository.signUp(authParams);
        // assert
        verify(mockRemoteDatasource.signUp(authParams));
        expect(result, equals(Right(signUpSuccess)));
      });
      test(
          'should return [Failure] when calling remote data base throws [ServerException]',
          () async {
        // arrange
        when(mockRemoteDatasource.signUp(authParams))
            .thenThrow((_) => ServerException());
        // act
        final result = await authRepository.signUp(authParams);
        // assert
        verify(mockRemoteDatasource.signUp(authParams));
        expect(result, equals(const Left(ServerFailure())));
      });
    });
    group('Get current auth user info sate', () {
      test(
        'should emit Right(AuthUserInfo) when getUserInfoState emits non-null value',
        () {
          // arrange
          const tUid = 'uid';
          const tEmail = 'test@test.com';
          const tDisplayName = 'displayName';
          const tPhotoURL = 'photoURL';
          const tPhoneNumber = 'phoneNumber';

          when(mockRemoteDatasource.getUserInfoState)
              .thenAnswer((_) => Stream.value(const AuthUserInfo(
                    uid: tUid,
                    email: tEmail,
                    displayName: tDisplayName,
                    photoUrl: tPhotoURL,
                    phoneNumber: tPhoneNumber,
                  )));
          // act
          final result = authRepository.userInfoState;
          // assert
          expectLater(
            result,
            emits(const Right(AuthUserInfo(
              uid: tUid,
              email: tEmail,
              displayName: tDisplayName,
              photoUrl: tPhotoURL,
              phoneNumber: tPhoneNumber,
            ))),
          );
        },
      );

      test(
        'should return [AuthenticatedFailure] when getUserInfoState returns null',
        () async {
          // arrange
          when(mockRemoteDatasource.getUserInfoState)
              .thenAnswer((_) => Stream.value(null));
          // act
          final result = authRepository.userInfoState;
          // assert
          expect(
            result,
            emitsInOrder([
              Left(AuthenticatedFailure()),
            ]),
          );
        },
      );

      test(
        'should emit [ServerFailure] when getUserInfoState throws a ServerException',
        () {
          // arrange
          when(mockRemoteDatasource.getUserInfoState).thenThrow(
            ServerException(errorMessage: "Server error"),
          );
          // act
          final result = authRepository.userInfoState;
          // assert
          expectLater(
            result,
            emits(const Left(ServerFailure(errorMessage: "Server error"))),
          );
        },
      );
      test(
        'should return [UnknownFailure] when getUserInfoState throws an unknown exception',
        () async {
          // arrange
          final tException = Exception('Unknown Error');
          when(mockRemoteDatasource.getUserInfoState).thenThrow(tException);
          // act
          final result = authRepository.userInfoState;
          // assert
          expect(
            result,
            emitsInOrder([
              Left(UnknownFailure(errorMessage: tException.toString())),
            ]),
          );
        },
      );
    });
    group('Log out', () {
      test(
        'should return [Void] when remoteDatasource.logOut completes successfully',
        () async {
          // arrange
          when(mockRemoteDatasource.logOut()).thenAnswer((_) => Future.value());
          // act
          final result = await authRepository.logOut();
          // assert
          expect(result, const Right(null));
        },
      );

      test(
        'should return [ServerFailure] when remoteDatasource.logOut throws an exception',
        () async {
          // arrange
          final tException = Exception('Server Error');
          when(mockRemoteDatasource.logOut()).thenThrow(tException);
          // act
          final result = await authRepository.logOut();
          // assert
          expect(
              result, Left(ServerFailure(errorMessage: tException.toString())));
        },
      );
    });
  });
}
