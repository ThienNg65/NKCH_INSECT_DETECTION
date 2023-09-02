import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  group('[Login Cubit]', () {
    late LoginCubit loginCubit;
    late MockEmailLogin mockEmailLogin;

    late LoginState loginState;
    late LoginSuccessEntity loginSuccess;
    const errorMessage = "Invalid data";

    setUp(() {
      mockEmailLogin = MockEmailLogin();
      loginCubit = LoginCubit(login: mockEmailLogin);

      loginState = LoginState.initial();
      loginSuccess = const LoginSuccessEntity(
        uid: 'uid',
        displayName: 'displayName',
        token: 'token',
      );
    });

    // Dispose bloc
    tearDown(() {
      loginCubit.close();
    });
    test('the status of the initial state is [Intial]', () async {
      expect(loginCubit.state, equals(loginState));
    });

    blocTest<LoginCubit, LoginState>(
      'should emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockEmailLogin.call(any))
            .thenAnswer((_) async => Right((loginSuccess)));
        return loginCubit;
      },
      act: (cubit) async {
        cubit.loginWithEmailCredential();
      },
      expect: () => [
        loginState.copyWith(
          status: LoginStatus.loading,
        ),
        loginState.copyWith(
          status: LoginStatus.success,
          message: loginSuccess.displayName,
        )
      ],
    );
    blocTest<LoginCubit, LoginState>(
      'should emits [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockEmailLogin.call(any)).thenAnswer((_) async =>
            const Left((ServerFailure(errorMessage: errorMessage))));
        return loginCubit;
      },
      act: (cubit) async {
        cubit.loginWithEmailCredential();
      },
      expect: () => [
        loginState.copyWith(
          status: LoginStatus.loading,
        ),
        loginState.copyWith(
          status: LoginStatus.error,
          message: errorMessage,
        )
      ],
    );
  });
}
