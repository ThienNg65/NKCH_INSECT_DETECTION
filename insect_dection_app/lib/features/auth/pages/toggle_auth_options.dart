// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class ToggleAuthOptions extends StatefulWidget {
  const ToggleAuthOptions({super.key});

  @override
  State<ToggleAuthOptions> createState() => _ToggleAuthOptionsState();
}

class _ToggleAuthOptionsState extends State<ToggleAuthOptions> {
  // initially, show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
