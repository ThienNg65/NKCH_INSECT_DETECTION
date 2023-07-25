// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

abstract class AuthRemoteDatasource {
  Future<SignUpResponse>? signUp(
    SignUpParams signUpParams,
  );

  Future<LoginResponse?> logIn(LoginParams loginParams);
}

class AuthRemoteDatasourceIml implements AuthRemoteDatasource {
  final FirebaseAuth _auth;

  AuthRemoteDatasourceIml(this._auth);

  @override
  Future<LoginResponse?> logIn(LoginParams loginParams) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: loginParams.email,
        password: loginParams.password,
      );
      final credential = userCredential.credential!;
      final user = userCredential.user!;

      final token = credential.accessToken!;

      final loginResponse = LoginResponse(
        uid: user.uid,
        token: token,
        displayName: user.displayName,
      );
      return loginResponse;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      final errorMessage = e.logInFailureMessageFromCode;
      // Show error message to user
      throw FirebaseErrorException(errorMesage: errorMessage);
    }
  }

  @override
  Future<SignUpResponse>? signUp(SignUpParams signUpParams) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: signUpParams.email,
        password: signUpParams.password,
      );
      final credential = userCredential.credential!;
      final user = userCredential.user!;

      final token = credential.accessToken!;

      final signUpResponse = SignUpResponse(
        uid: user.uid,
        token: token,
      );
      return signUpResponse;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      final errorMessage = e.logInFailureMessageFromCode;
      // Show error message to user
      throw FirebaseErrorException(errorMesage: errorMessage);
    }
  }
}

extension MapFirebaseAuthException on FirebaseAuthException {
  String get signUpFailureMessageFromCode {
    switch (code) {
      case 'invalid-email':
        return 'Email is not valid or badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'operation-not-allowed':
        return 'Operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'Please enter a stronger password.';
      default:
        return "An unknown error has occurred.";
    }
  }

  String get logInFailureMessageFromCode {
    switch (code) {
      case 'invalid-email':
        return 'Email is not valid or badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'user-not-found':
        return 'Email is not found, please create an account.';
      case 'wrong-password':
        return 'Incorrect password, please try again.';
      default:
        return "An unknown error has occurred.";
    }
  }
}
