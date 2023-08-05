import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/pages/auth_warpper/bloc/auth_bloc.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  group('[Authentication Bloc]', () {
    late AuthBloc authBloc;
    late MockGetCurrentAuthUserInfoStream mockGetCurrentAuthUserInfoStream;
    late MockLogOutRequested mockLogOutRequested;

    late AuthUserInfo mockAuthUser;

    setUp(() {
      mockGetCurrentAuthUserInfoStream = MockGetCurrentAuthUserInfoStream();

      mockLogOutRequested = MockLogOutRequested();
      when(mockGetCurrentAuthUserInfoStream(any))
          .thenAnswer((_) => Stream.value(const Right(AuthUserInfo.empty)));
      authBloc = AuthBloc(
        getAuthUserStream: mockGetCurrentAuthUserInfoStream,
        logOutRequested: mockLogOutRequested,
      );

      mockAuthUser = const AuthUserInfo(uid: 'test-uid');
    });

    // Dispose bloc
    tearDown(() {
      authBloc.close();
    });

    ///  Initial data should be loading
    test('initial state is [unauthenticated]', () async {
      expect(authBloc.state, equals(const AuthState.unauthenticated()));
    });
    blocTest<AuthBloc, AuthState>(
      'should call [GetCurrentAuthUserInfoStream] when created',
      build: () {
        when(mockGetCurrentAuthUserInfoStream(any))
            .thenAnswer((_) => Stream.value(const Right(AuthUserInfo.empty)));
        return authBloc;
      },
      verify: (_) {
        verify(mockGetCurrentAuthUserInfoStream(any));
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [Authenticated] when user sign in successfully.',
      build: () {
        when(mockGetCurrentAuthUserInfoStream.call(any))
            .thenAnswer((_) => Stream.value(Right(mockAuthUser)));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthUserChanged(mockAuthUser)),
      expect: () => [
        AuthState.authenticated(mockAuthUser),
      ],
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [unauthenticated] when usecase called  return empty authenticated user.',
      build: () {
        when(mockGetCurrentAuthUserInfoStream(any))
            .thenAnswer((_) => Stream.value(const Right(AuthUserInfo.empty)));
        return AuthBloc(
          getAuthUserStream: mockGetCurrentAuthUserInfoStream,
          logOutRequested: mockLogOutRequested,
        );
      },
      act: (bloc) => bloc.add(const AuthUserChanged(AuthUserInfo.empty)),
      expect: () => [
        // const AuthState.unauthenticated(),
        const AuthState.unauthenticated(),
      ],
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [unauthenticated] when usecase called return [ServerFailure].',
      build: () {
        when(mockGetCurrentAuthUserInfoStream.call(any))
            .thenAnswer((_) => Stream.value(Right(mockAuthUser)));
        when(mockGetCurrentAuthUserInfoStream(any))
            .thenAnswer((_) => Stream.value(const Left(ServerFailure())));
        return AuthBloc(
          getAuthUserStream: mockGetCurrentAuthUserInfoStream,
          logOutRequested: mockLogOutRequested,
        );
      },
      act: (bloc) => bloc.add(const AuthUserChanged(AuthUserInfo.empty)),
      expect: () => [
        // const AuthState.unauthenticated(),
        const AuthState.unauthenticated(),
      ],
    );
    blocTest<AuthBloc, AuthState>(
      'emits [authenticated, unauthenticated] when LogOutRequested is called  after use signed in.',
      build: () {
        when(mockLogOutRequested.call(any))
            // ignore: void_checks
            .thenAnswer((_) async => const Right(Void));
        return AuthBloc(
          getAuthUserStream: mockGetCurrentAuthUserInfoStream,
          logOutRequested: mockLogOutRequested,
        );
      },
      act: (bloc) {
        bloc.add(AuthUserChanged(mockAuthUser));
        bloc.add(AuthLogoutRequested());
      },
      expect: () => [
        AuthState.authenticated(mockAuthUser),
        const AuthState.unauthenticated(),
      ],
    );
  });
}
