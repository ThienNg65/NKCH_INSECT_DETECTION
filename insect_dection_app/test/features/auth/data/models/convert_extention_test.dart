import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/services/firebase_auth.mocks.dart';



void main() {
  group('[Firebase Convertion]', () {
    group('MapFromFirebaseToAuthUser', () {
      test('fromJson creates correct AuthUserInfo', () {
        // Arrange
        final data = {
          'uid': 'testUid',
          'email': 'testEmail',
          'displayName': 'testDisplayName',
          'photoUrl': 'testPhotoUrl',
          'phoneNumber': 'testPhoneNumber',
        };
        final user = MockUser();

        // Act
        final authUserInfo = user.fromJson(data);

        // Assert
        expect(authUserInfo.uid, equals('testUid'));
        expect(authUserInfo.email, equals('testEmail'));
        expect(authUserInfo.displayName, equals('testDisplayName'));
        expect(authUserInfo.photoUrl, equals('testPhotoUrl'));
        expect(authUserInfo.phoneNumber, equals('testPhoneNumber'));
      });

      test('toAuthUserInfo creates correct AuthUserInfo', () {
        // Arrange
        final user = MockUser();
        when(user.uid).thenReturn('testUid');
        when(user.email).thenReturn('testEmail');
        when(user.displayName).thenReturn('testDisplayName');
        when(user.photoURL).thenReturn('testPhotoUrl');
        when(user.phoneNumber).thenReturn('testPhoneNumber');

        // Act
        final authUserInfo = user.toAuthUserInfo;

        // Assert
        expect(authUserInfo.uid, equals('testUid'));
        expect(authUserInfo.email, equals('testEmail'));
        expect(authUserInfo.displayName, equals('testDisplayName'));
        expect(authUserInfo.photoUrl, equals('testPhotoUrl'));
        expect(authUserInfo.phoneNumber, equals('testPhoneNumber'));
      });
    });
    group('FailureMessageFromCode', () {
      test('should return correct error message for invalid email', () {
        final firebaseAuthException = FirebaseAuthException(
          code: 'invalid-email',
          message: 'Email is not valid or badly formatted.',
        );

        final errorMsg = firebaseAuthException.logInFailureMessageFromCode;

        expect(errorMsg, 'Email is not valid or badly formatted.');
      });

      test('should return correct error message for user not found', () {
        final firebaseAuthException = FirebaseAuthException(
          code: 'user-not-found',
          message: 'Email is not found, please create an account.',
        );

        final errorMsg = firebaseAuthException.logInFailureMessageFromCode;

        expect(errorMsg, 'Email is not found, please create an account.');
      });
    });
  });
}
