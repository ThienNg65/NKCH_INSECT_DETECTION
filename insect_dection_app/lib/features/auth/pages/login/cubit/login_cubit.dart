import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailLogin _login;

  LoginCubit({
    required EmailLogin login,
  })  : _login = login,
        super(LoginState.initial());

  void onEmailChanged(String value) {
    emit(state.copyWith(
      status: LoginStatus.intial,
      email: value,
    ));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(
      status: LoginStatus.intial,
      password: value,
    ));
  }

  Future<void> loginWithEmailCredential() async {
    /// Check the state
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));

    /// Calling Usecase Login
    final loginParams = AuthenticationParams(
      email: state.email,
      password: state.password,
    );
    final loginResult = await _login(loginParams);

    /// Handle emits states based on result types
    loginResult.fold(
      (failure) {
        final failureMessage = (failure is ServerFailure)
            ? (failure.errorMessage ?? '')
            : '"An unknown error has occurred."';
        emit(state.copyWith(
          status: LoginStatus.error,
          message: failureMessage,
        ));
      },
      (loginSuccess) {
        emit(state.copyWith(
          status: LoginStatus.success,
          message: loginSuccess.displayName,
        ));
      },
    );
  }
}
