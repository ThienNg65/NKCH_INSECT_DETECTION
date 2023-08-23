import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension MapFromFirebaseToAuthUser on User {
  AuthUserInfo fromJson(Map<dynamic, dynamic> data) => AuthUserInfo(
        uid: data['uid'] as String,
        email: data['email'] as String?,
        displayName: data['displayName'] as String?,
        photoUrl: data['photoUrl'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
      );
  AuthUserInfo get toAuthUserInfo {
    return AuthUserInfo(
      uid: uid,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      photoUrl: photoURL,
    );
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
        return toString();
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
        return toString();
    }
  }
}
