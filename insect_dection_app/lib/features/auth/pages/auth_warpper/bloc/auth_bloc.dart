import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentAuthUserInfoStream _getCurrentAuthUserInfoStream;
  late final StreamSubscription<Either<Failure, AuthUserInfo>>
      _userSubscription;
  final LogOutRequested _logOutRequested;

  AuthBloc({
    required GetCurrentAuthUserInfoStream getAuthUserStream,
    required LogOutRequested logOutRequested,
  })  : _getCurrentAuthUserInfoStream = getAuthUserStream,
        _logOutRequested = logOutRequested,
        super(const AuthState.unauthenticated()) {
    /// Intial Event
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);

    /// Initial stream
    final userInfoStream = _getCurrentAuthUserInfoStream(NoParams());
    _userSubscription = userInfoStream.listen((result) {
      result.fold(
        (failure) => add(const AuthUserChanged(AuthUserInfo.empty)),
        (userInfo) => add(AuthUserChanged(userInfo)),
      );
    });
  }

  Future<void> _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      event.userInfo.isNotEmpty
          ? AuthState.authenticated(event.userInfo)
          : const AuthState.unauthenticated(),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    unawaited(_logOutRequested(NoParams()));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
