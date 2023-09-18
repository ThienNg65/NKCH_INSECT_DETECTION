import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/features/user/user.dart';
import 'package:insect_dection_app/injection_container.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocProvider<UserProfileBloc>.value(
        value: sl<UserProfileBloc>(),
        child: const ProfilePageScreen(),
      ),
    );
  }
}
