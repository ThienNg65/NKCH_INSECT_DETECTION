import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/general/general.dart';

import 'package:insect_dection_app/injection_container.dart' as di;

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState.status == AuthStatus.authenticated) {
            return const HomePage();
          } else {
            if (authState.status == AuthStatus.unauthenticated) {
              return const ToggleAuthOptions();
            } else {
              return const Scaffold();
            }
          }
        },
      ),
    );
  }
}
