// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final EmailSignUp _signUp;
  final CreateUserProfile _createUserProfile;
  SignUpCubit({
    required EmailSignUp signUp,
    required CreateUserProfile createUserProfile,
  })  : _signUp = signUp,
        _createUserProfile = createUserProfile,
        super(SignUpState.initial());

  get isPasswordMatch {
    if (state.password == state.confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  void onEmailChanged(String? value) {
    emit(state.copyWith(
      status: SignUpStatus.initial,
      email: value,
    ));
  }

  void onPasswordChanged(String? value) {
    emit(state.copyWith(
      status: SignUpStatus.initial,
      password: value,
    ));
  }

  void onConfirmChanged(String? value) {
    emit(state.copyWith(
      status: SignUpStatus.initial,
      confirmPassword: value,
    ));
  }

  Future<void> signUpWithEmailCredential() async {
    /// Check the state
    if (state.status == SignUpStatus.loading) return;
    emit(state.copyWith(status: SignUpStatus.loading));

    /// Calling Usecase Sign Up
    AuthenticationParams signUpParams = AuthenticationParams(
      email: state.email,
      password: state.password,
    );
    final singUpResult = await _signUp(signUpParams);

    /// Handle emits states based on result types
    singUpResult.fold((failure) {
      final failureMessage =
          failure.errorMessage ?? "An unknown error has occurred.";
      emit(state.copyWith(
        status: SignUpStatus.error,
        message: failureMessage,
      ));
    }, (signUpSuccess) async {
      emit(state.copyWith(
        status: SignUpStatus.success,
        message: state.email,
      ));
      _onSignUpSucesss(entity: signUpSuccess);
    });
  }

  Future<void> _onSignUpSucesss({required SignUpSuccessEntity entity}) async {
    final userParams = UserParams(
      uid: entity.uid,
      username: state.email,
    );

    final result = await _createUserProfile(userParams);

    result!.fold(
      (Failure failure) {
        emit(state.copyWith(
          status: SignUpStatus.error,
          message: failure.errorMessage,
        ));
      },
      (UserProfileEntity user) {
        emit(state.copyWith(
          status: SignUpStatus.success,
          message: state.email,
        ));
      },
    );
  }
}
