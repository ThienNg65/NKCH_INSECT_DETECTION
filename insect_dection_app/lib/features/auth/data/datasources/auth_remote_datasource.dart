import 'package:firebase_auth/firebase_auth.dart';
import 'package:insect_dection_app/core/error/error.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/user/user.dart';

abstract class AuthRemoteDatasource {
  Stream<AuthUserInfo?> get getUserInfoState;
  Future<SignUpResponse>? signUp(AuthenticationParams signUpParams);

  Future<LoginResponse?> logIn(AuthenticationParams loginParams);

  Future<void> logOut();
}

class AuthRemoteDatasourceIml implements AuthRemoteDatasource {
  final FirebaseAuth _auth;

  AuthRemoteDatasourceIml({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<LoginResponse?> logIn(AuthenticationParams loginParams) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: loginParams.email,
        password: loginParams.password,
      );

      final user = userCredential.user;

      final uid = user?.uid as String;
      final token = await user?.getIdToken() as String;
      final displayName = user?.displayName ?? user?.email;

      final loginResponse = LoginResponse(
        uid: uid,
        token: token,
        displayName: displayName,
      );
      return loginResponse;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      final errorMessage = e.logInFailureMessageFromCode;
      // Show error message to user
      throw FirebaseErrorException(errorMessage: errorMessage);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<SignUpResponse>? signUp(AuthenticationParams signUpParams) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: signUpParams.email,
        password: signUpParams.password,
      );
      final user = userCredential.user;

      final uid = user?.uid as String;
      final token = await user?.getIdToken() as String;

      final signUpResponse = SignUpResponse(
        uid: uid,
        token: token,
      );
      return signUpResponse;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      final errorMessage = e.signUpFailureMessageFromCode;
      // Show error message to user
      throw FirebaseErrorException(errorMessage: errorMessage);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> logOut() => _auth.signOut();

  @override
  Stream<AuthUserInfo?> get getUserInfoState {
    try {
      return _auth.authStateChanges().map((user) {
        if (user == null) {
          return null;
        } else {
          return AuthUserInfo(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            photoUrl: user.photoURL,
            phoneNumber: user.phoneNumber,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      final errorMessage = e.logInFailureMessageFromCode;
      // Show error message to user
      throw FirebaseErrorException(errorMessage: errorMessage);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }
}
