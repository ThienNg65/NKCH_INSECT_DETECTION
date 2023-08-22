  import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

import 'package:mockito/mockito.dart';

import '../../../../helpers/services/firebase_auth.mocks.dart';



void main() {
  group('[Authentication Remote Datasource] ', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late AuthRemoteDatasourceIml remoteDatasource;

    late AuthenticationParams authParams;

    late MockUserCredential mockUserCredential;
    late MockUser mockUser;

    late LoginResponse loginResponse;
    late SignUpResponse signUpResponse;

    const tEmail = 'test@test.com';
    const tPassword = 'password';
    const tUid = 'uid';
    const tToken = 'token';
    const tDisplayName = 'displayName';
    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      remoteDatasource = AuthRemoteDatasourceIml(auth: mockFirebaseAuth);

      authParams = const AuthenticationParams(
        email: tEmail,
        password: tPassword,
      );
      mockUserCredential = MockUserCredential();
      mockUser = MockUser();

      loginResponse = const LoginResponse(
        uid: tUid,
        token: tToken,
        displayName: tDisplayName,
      );
      signUpResponse = const SignUpResponse(
        uid: tUid,
        token: tToken,
      );
    });

    void setUpLogInReturnValidCredential() {
      /// Mock User
      when(mockUser.uid).thenReturn('uid');
      when(mockUser.displayName).thenReturn(tDisplayName);
      when(mockUser.getIdToken()).thenAnswer((_) async => tToken);

      /// Mock User Credential
      when(mockUserCredential.user).thenReturn(mockUser);

      /// Login
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
    }

    void setUpSignUpReturnValidCredential() {
      /// Mock User
      when(mockUser.uid).thenReturn('uid');
      when(mockUser.getIdToken()).thenAnswer((_) async => tToken);

      /// Mock User Credential
      when(mockUserCredential.user).thenReturn(mockUser);

      /// Sign Up
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
    }

    group('Login with Email and Password', () {
      test(
        'should return [LoginResponse] when logIn is called with valid credentials',
        () async {
          /// Arrange
          setUpLogInReturnValidCredential();

          /// Act
          final result = await remoteDatasource.logIn(authParams);

          /// Assert
          verify(mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ));
          expect(result, isA<LoginResponse>());
          expect(result, equals(loginResponse));
        },
      );
      test(
        'should throw [FirebaseErrorException] when logIn is called and FirebaseAuth throws FirebaseAuthException',
        () async {
          // Arrange
          when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

          // Act
          final call = remoteDatasource.logIn;

          // Assert
          expect(
              () => call(authParams), throwsA(isA<FirebaseErrorException>()));
        },
      );
      test(
        'should throw [ServerException] when there is an unknown exception',
        () async {
          // arrange
          when(mockFirebaseAuth.createUserWithEmailAndPassword(
                  email: anyNamed('email'), password: anyNamed('password')))
              .thenThrow(Exception());
          // act
          final call = remoteDatasource.logIn;
          // assert
          expect(() => call(authParams), throwsA(isA<ServerException>()));
        },
      );
    });

    group('SignUp with Email and Password', () {
      test(
        'should return [SignUpResponse] when signUp is called with valid credentials',
        () async {
          // Arrange
          setUpSignUpReturnValidCredential();

          // Act
          final result = await remoteDatasource.signUp(authParams);

          // Assert
          verify(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ));
          expect(result, isA<SignUpResponse>());
          expect(result, equals(signUpResponse));
        },
      );

      test(
        'should throw [FirebaseErrorException] when signUp is called and FirebaseAuth throws FirebaseAuthException',
        () async {
          when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

          // Act
          final call = remoteDatasource.signUp;

          // Assert
          expect(
              () => call(authParams), throwsA(isA<FirebaseErrorException>()));
        },
      );
      test(
        'should throw [ServerException] when there is an unknown exception',
        () async {
          // arrange
          when(mockFirebaseAuth.createUserWithEmailAndPassword(
                  email: anyNamed('email'), password: anyNamed('password')))
              .thenThrow(Exception());
          // act
          final call = remoteDatasource.signUp;
          // assert
          expect(() => call(authParams), throwsA(isA<ServerException>()));
        },
      );
    });
    group('Logout', () {
      test('Log out calls [signOut] on FirebaseAuth', () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenAnswer((_) => Future.value());

        // Act
        await remoteDatasource.logOut();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
      });
    });
    group('Get Authenticated User Status Stream', () {
      test('should emit correct [AuthUserInfo]', () async {
        // Arrange
        final user = MockUser();
        when(user.uid).thenReturn('testUid');
        when(user.email).thenReturn('testEmail');
        when(user.displayName).thenReturn('testDisplayName');
        when(user.photoURL).thenReturn('testPhotoUrl');
        when(user.phoneNumber).thenReturn('testPhoneNumber');
        when(mockFirebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(user));

        // Act
        final result = remoteDatasource.getUserInfoState;

        // Assert
        expectLater(
          result,
          emitsInOrder([
            predicate<AuthUserInfo>((authUserInfo) {
              return authUserInfo.uid == 'testUid' &&
                  authUserInfo.email == 'testEmail' &&
                  authUserInfo.displayName == 'testDisplayName' &&
                  authUserInfo.photoUrl == 'testPhotoUrl' &&
                  authUserInfo.phoneNumber == 'testPhoneNumber';
            }),
          ]),
        );
      });
      test('should emit [null] after logOut', () async {
        /// Arrange
        //Return the user at first
        final user = MockUser();
        when(user.uid).thenReturn('testUid');
        when(user.email).thenReturn('testEmail');
        when(user.displayName).thenReturn('testDisplayName');
        when(user.photoURL).thenReturn('testPhotoUrl');
        when(user.phoneNumber).thenReturn('testPhoneNumber');

        // Arrange the stream for authStateChanges
        final authStateChangesController = StreamController<User?>();
        when(mockFirebaseAuth.authStateChanges())
            .thenAnswer((_) => authStateChangesController.stream);
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async {
          authStateChangesController.add(null);
        });

        /// Act
        final result = remoteDatasource.getUserInfoState;
        // Login or Resigter
        authStateChangesController.add(user);
        await remoteDatasource.logOut();

        /// Assert
        expectLater(
          result,
          emitsInOrder([
            predicate<AuthUserInfo>((authUserInfo) {
              return authUserInfo.uid == 'testUid' &&
                  authUserInfo.email == 'testEmail' &&
                  authUserInfo.displayName == 'testDisplayName' &&
                  authUserInfo.photoUrl == 'testPhotoUrl' &&
                  authUserInfo.phoneNumber == 'testPhoneNumber';
            }),
            null,
          ]),
        );

        /// Clean up
        await authStateChangesController.close();
      });
    });
  });
}
