import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:insect_dection_app/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: BlocProvider.value(
          value: sl<HomePageBloc>.call(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
