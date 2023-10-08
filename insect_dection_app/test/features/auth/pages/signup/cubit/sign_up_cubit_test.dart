import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';
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
    late UserProfileEntity userProfileEntity;
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
      userProfileEntity = const UserProfileModel(
        /// Account Identity
        uid: "test_3@-uid",
        username: "nvtt@gmail.com",
      );
    });
    tearDown(() {
      signUpCubit.close();
    });

    test('the status of the initial state is [Intial]', () async {
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
          signUpSuccess: signUpSuccess,
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
    blocTest<SignUpCubit, SignUpState>(
      'should emits [Success, Success] when user profile is created successfully',
      build: () {
        when(mockEmailSignUp.call(any))
            .thenAnswer((_) async => Right((signUpSuccess)));
        signUpCubit.signUpWithEmailCredential();

        when(mockCreateUserProfile.call(any))
            .thenAnswer((_) async => Right((userProfileEntity)));
        return signUpCubit;
      },
      act: (cubit) async {
        cubit.createUserProfile();
      },
      expect: () => [
        signUpState.copyWith(
          status: SignUpStatus.success,
          signUpSuccess: signUpSuccess,
        )
      ],
    );
  });
}
