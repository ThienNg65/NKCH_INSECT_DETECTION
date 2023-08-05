// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => RegisterPageSate();
}

class RegisterPageSate extends State<RegisterPage> {
  // Initially password is obscure
  bool _obscureText = true;

  // TEXT CONTROLLER
  // final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();
  // final TextEditingController confirmPassword = TextEditingController();
  // final TextEditingController firstName = TextEditingController();
  // final TextEditingController lastName = TextEditingController();
  // final TextEditingController age = TextEditingController();

  // check if the confirm password matches the password
  bool passwordConfirmed() {
    // if (confirmPassword.text.trim() == password.text.trim()) {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
  }

  void onEmailChanged(String? value) {
    BlocProvider.of<SignUpCubit>(context).onEmailChanged(value);
  }

  void onPasswordChanged(String? value) {
    BlocProvider.of<SignUpCubit>(context).onPasswordChanged(value);
  }

  void onConfirmChanged(String? value) {
    BlocProvider.of<SignUpCubit>(context).onConfirmChanged(value);
  }
  // void onFirstNameChanged(String value) {}
  // void onLasNameChanged(String value) {}
  // void onAgeChanged(String value) {}

  Future signUp() async {
    BlocProvider.of<SignUpCubit>(context).signUpWithEmailCredential();
  }

  @override
  void dispose() {
    // email.dispose();
    // password.dispose();
    // confirmPassword.dispose();
    // firstName.dispose();
    // lastName.dispose();
    // age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello again!
                Text(
                  "Hello new pal!",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  // ignore: unnecessary_string_escapes
                  "Please register to access further 🥰",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 50),

                // // first name textfield
                // _firstNameInput(),
                // const SizedBox(height: 10),

                // // last name textfield
                // _lastNameInput(),
                // const SizedBox(height: 10),

                // // age textfield
                // _ageInput(),
                // const SizedBox(height: 10),

                // email textfield
                _emailInput(),
                const SizedBox(height: 10),

                //password textfield
                _passwordInput(),
                const SizedBox(height: 10),

                // confirm password textfield
                _comfirmPasswordInput(),
                const SizedBox(height: 10),

                // sign up button
                _signIn(),
                const SizedBox(height: 25),

                // not a member? register one
                _toggleRegsiterOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Padding _firstNameInput() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //     child: TextFormField(
  //       key: const Key('registerForm_firstNameInput_textField'),
  //       controller: firstName,
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blueAccent),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         hintText: 'First Name',
  //         fillColor: Colors.grey[100],
  //         filled: true,
  //       ),
  //     ),
  //   );
  // }

  // Padding _lastNameInput() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //     child: TextFormField(
  //       key: const Key('registerForm_lastNameInput_textField'),
  //       controller: lastName,
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blueAccent),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         hintText: 'Last name',
  //         fillColor: Colors.grey[100],
  //         filled: true,
  //       ),
  //     ),
  //   );
  // }

  // Padding _ageInput() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //     child: TextFormField(
  //       key: const Key('registerForm_ageInput_textField'),
  //       controller: age,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.white),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.blueAccent),
  //           borderRadius: BorderRadius.circular(12.0),
  //         ),
  //         hintText: 'Age',
  //         fillColor: Colors.grey[100],
  //         filled: true,
  //       ),
  //     ),
  //   );
  // }

  _emailInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            key: const Key('registerForm_emailInput_textField'),
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
      },
    );
  }

  _passwordInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            key: const Key('registerForm_passwordInput_textField'),
            // controller: password,
            obscureText: _obscureText,
            validator: (_) {
              if (BlocProvider.of<SignUpCubit>(context).isPasswordMatch) {
                return 'Passwords do not match';
              } else {
                return null;
              }
            },
            onChanged: onPasswordChanged,
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

  _comfirmPasswordInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            key: const Key('registerForm_confrimInput_textField'),
            // controller: confirmPassword,
            obscureText: _obscureText,
            validator: (_) {
              if (BlocProvider.of<SignUpCubit>(context).isPasswordMatch) {
                return 'Passwords do not match';
              } else {
                return null;
              }
            },
            onChanged: onConfirmChanged,
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
              hintText: 'Confirm Password',
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

  _signIn() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return (state.status == SignUpStatus.loading)
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  key: const Key('registerForm_signUp_gestureDetector'),
                  onTap: BlocProvider.of<SignUpCubit>(context).isPasswordMatch
                      ? signUp
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
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

  Row _toggleRegsiterOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already a member?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: widget.showLoginPage,
          child: const Text(
            'Login',
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
}
