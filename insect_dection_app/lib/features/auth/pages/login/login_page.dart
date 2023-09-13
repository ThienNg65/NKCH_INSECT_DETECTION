// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Feilds
  // Initially password is obscure
  bool _obscureText = true;

  /// TEXT CONTROLLER
  // final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();

  /// Methods
  Future<void> signIn() async {
    BlocProvider.of<LoginCubit>(context).loginWithEmailCredential();
  }

  void onEmailChanged(String value) {
    BlocProvider.of<LoginCubit>(context).onEmailChanged(value);
  }

  void onPasswordChanged(String value) {
    BlocProvider.of<LoginCubit>(context).onPasswordChanged(value);
  }

  @override
  void dispose() {
    // email.dispose();
    // password.dispose();
    super.dispose();
  }

  /// UIs
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (_, state) {
        if (state.status == LoginStatus.error) {
          showTopSnackBar(context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hello again!
                  Text(
                    "Hello again!",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // email textfield
                  _emailInput(),
                  const SizedBox(height: 10),

                  //password textfield
                  _passwordInput(),

                  const SizedBox(height: 10),

                  _toggleForgetPassoword(context),

                  const SizedBox(height: 10),

                  // sign button
                  _signIn(context),
                  const SizedBox(height: 25),

                  // not a member? register one
                  _toggleRegsiterOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _toggleRegsiterOption() {
    return Row(
      key: const Key('loginForm_toggleRegsiter_textField'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not a member?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: widget.showRegisterPage,
          child: const Text(
            'Register one',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  _signIn(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return (state.status == LoginStatus.loading)
            ? const CircularProgressIndicator()
            : Padding(
                key: const Key('loginForm_Login_CustomButton'),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  _toggleForgetPassoword(BuildContext context) {
    return Padding(
      key: const Key('loginForm_ForgetPassoword_textField'),
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForgotPasswordPage();
                  },
                ),
              );
            },
            child: Text(
              'Forgot password?',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _passwordInput() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            key: const Key('loginForm_passwordInput_textField'),
            // controller: password,
            obscureText: _obscureText,
            onChanged: onPasswordChanged,
            validator: (password) {
              if (password!.isEmpty || password.length < 7) {
                return 'Please enter a valid password';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(12.0),
              ),
              hintText: 'Password',
              fillColor: Colors.grey[100],
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
                // THE EYE ICON
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _emailInput() {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              key: const Key('loginForm_emailInput_textField'),
              // controller: email,
              onChanged: onEmailChanged,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
          );
        });
  }
}
