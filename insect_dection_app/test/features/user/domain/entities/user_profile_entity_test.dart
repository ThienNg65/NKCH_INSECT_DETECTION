import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';

void main() {
  group('UserProfileEntity', () {
    test('props should return all fields', () {
      // Arrange
      final userProfileEntity = UserProfileEntity(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address.empty,
        photoUrl: 'photoUrl',
      );

      // Act
      final props = userProfileEntity.props;

      // Assert
      expect(props.length, 7);
      expect(
          props,
          containsAll([
            'uid',
            'username',
            'phoneNumber',
            'firstName',
            'lastName',
            Address.empty,
            'photoUrl',
          ]));
    });

    test(
        'copyWith() should create a new UserProfileEntity with the updated fields',
        () {
      // Arrange
      final userProfileEntity = UserProfileEntity(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address.empty,
        photoUrl: 'photoUrl',
      );

      // Act
      final newUserProfileEntity = userProfileEntity.copyWith(
        username: 'newUsername',
        phoneNumber: 'newPhoneNumber',
        firstName: 'newFirstName',
        lastName: 'newLastName',
        address: Address.empty.copyWith(
          street: 'street',
          city: 'city',
          country: 'state',
        ),
        photoUrl: 'newPhotoUrl',
      );

      // Assert
      expect(newUserProfileEntity.uid, userProfileEntity.uid);
      expect(newUserProfileEntity.username, 'newUsername');
      expect(newUserProfileEntity.phoneNumber, 'newPhoneNumber');
      expect(newUserProfileEntity.firstName, 'newFirstName');
      expect(newUserProfileEntity.lastName, 'newLastName');
      expect(
          newUserProfileEntity.address,
          const Address(
            street: 'street',
            city: 'city',
            country: 'state',
          ));
      expect(newUserProfileEntity.photoUrl, 'newPhotoUrl');
    });
  });
}
