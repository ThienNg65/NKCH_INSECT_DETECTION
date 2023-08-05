// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final EmailSignUp _signUp;
  SignUpCubit({
    required EmailSignUp signUp,
  })  : _signUp = signUp,
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
      status: SignUpStatus.intial,
      email: value,
    ));
  }

  void onPasswordChanged(String? value) {
    emit(state.copyWith(
      status: SignUpStatus.intial,
      password: value,
    ));
  }

  void onConfirmChanged(String? value) {
    emit(state.copyWith(
      status: SignUpStatus.intial,
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
      final failureMessage = (failure is ServerFailure)
          ? (failure.errorMessage ?? '')
          : '"An unknown error has occurred."';
      emit(state.copyWith(
        status: SignUpStatus.error,
        message: failureMessage,
      ));
    }, (signUpSuccess) {
      emit(state.copyWith(
        status: SignUpStatus.success,
        message: state.email,
      ));
    });
  }
}
