import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/auth/auth_domain.mocks.dart';
import '../../../../../helpers/user/user_domain.mocks.dart';

void main() {
  group('[SignIn Cubit]', () {
    late SignUpCubit signUpCubit;
    late MockEmailSignUp mockEmailSignUp;
    late MockCreateUserProfile mockCreateUserProfile;

    late SignUpState signUpState;
    late SignUpSuccessEntity signUpSuccess;
    const errorMessage = "Invalid data";

    setUp(() {
      mockEmailSignUp = MockEmailSignUp();
      mockCreateUserProfile = MockCreateUserProfile();
      signUpCubit = SignUpCubit(
        signUp: mockEmailSignUp,
        createUserProfile: mockCreateUserProfile,
      );

      signUpState = SignUpState.initial();
      signUpSuccess = const SignUpSuccessEntity(
        token: 'token',
        uid: 'uid',
      );
    });
    tearDown(() {
      signUpCubit.close();
    });

    test('the status of the intial state is [Intial]', () async {
      expect(signUpCubit.state, equals(signUpState));
    });
    blocTest<SignUpCubit, SignUpState>(
      'should emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockEmailSignUp.call(any))
            .thenAnswer((_) async => Right((signUpSuccess)));
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.signUpWithEmailCredential();
      },
      expect: () => [
        signUpState.copyWith(
          status: SignUpStatus.loading,
        ),
        signUpState.copyWith(
          status: SignUpStatus.success,
        )
      ],
    );
    blocTest<SignUpCubit, SignUpState>(
      'should emits [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockEmailSignUp.call(any)).thenAnswer((_) async =>
            const Left((ServerFailure(errorMessage: errorMessage))));
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.signUpWithEmailCredential();
      },
      expect: () => [
        signUpState.copyWith(
          status: SignUpStatus.loading,
        ),
        signUpState.copyWith(
          status: SignUpStatus.error,
          message: errorMessage,
        )
      ],
    );
  });
}
