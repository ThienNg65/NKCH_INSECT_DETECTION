import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/firebase_auth.mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRemoteDatasourceIml remoteDatasource;

  late LoginParams loginParams;
  late SignUpParams signUpParams;

  late MockUserCredential mockUserCredential;
  late MockAuthCredential mockAuthCredential;
  late MockUser mockUser;

  late LoginResponse loginResponse;
  late SignUpResponse signUpResponse;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    remoteDatasource = AuthRemoteDatasourceIml(mockFirebaseAuth);

    loginParams = const LoginParams(
      email: 'test@test.com',
      password: 'password',
    );
    signUpParams = const SignUpParams(
      email: 'test@test.com',
      password: 'password',
    );

    mockUserCredential = MockUserCredential();
    mockAuthCredential = MockAuthCredential();
    mockUser = MockUser();

    loginResponse = const LoginResponse(
      uid: 'uid',
      token: 'accessToken',
      displayName: 'displayName',
    );
    signUpResponse = const SignUpResponse(
      uid: 'uid',
      token: 'accessToken',
    );
  });

  void setUpLogInReturnValidLoginCredential() {
    when(mockUser.uid).thenReturn('uid');
    when(mockUser.displayName).thenReturn('displayName');
    when(mockAuthCredential.accessToken)
        .thenReturn('accessToken'); // Add stub for accessToken property
    when(mockUserCredential.credential).thenReturn(mockAuthCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockFirebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => mockUserCredential);
  }

  void setUpSignUpReturnValidLoginCredential() {
    when(mockUser.uid).thenReturn('uid');
    when(mockAuthCredential.accessToken).thenReturn('accessToken');
    when(mockUserCredential.credential).thenReturn(mockAuthCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => mockUserCredential);
  }

  group('[Authentication Remote Datasource] Login with Email and Password', () {
    test(
      'Should return [LoginResponse] when logIn is called with valid credentials',
      () async {
        // Arrange
        setUpLogInReturnValidLoginCredential();

        // Act
        final result = await remoteDatasource.logIn(loginParams);

        // Assert
        expect(result, isA<LoginResponse>());
        expect(result, loginResponse);
      },
    );
    test(
      'Should throw [FirebaseErrorException] when logIn is called and FirebaseAuth throws FirebaseAuthException',
      () async {
        // Arrange
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        // Act
        final call = remoteDatasource.logIn;

        // Assert
        expect(() => call(loginParams), throwsA(isA<FirebaseErrorException>()));
      },
    );
  });

  group('[Authentication Remote Datasource] SignUp with Email and Password',
      () {
    test(
      'Should return [SignUpResponse] when signUp is called with valid credentials',
      () async {
        // Arrange
        setUpSignUpReturnValidLoginCredential();

        // Act
        final result = await remoteDatasource.signUp(signUpParams);

        // Assert
        expect(result, isA<SignUpResponse>());
        expect(result, signUpResponse);
      },
    );

    test(
      'Should throw [FirebaseErrorException] when signUp is called and FirebaseAuth throws FirebaseAuthException',
      () async {
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        // Act
        final call = remoteDatasource.signUp;

        // Assert
        expect(
            () => call(signUpParams), throwsA(isA<FirebaseErrorException>()));
      },
    );
  });
}
