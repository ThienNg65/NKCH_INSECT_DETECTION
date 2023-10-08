// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('UserProfileModel', () {
    test('toMap() should return a map with all the fields of the model', () {
      // Arrange
      const userProfileModel = UserProfileModel(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );

      // Act
      final map = userProfileModel.toMap();

      // Assert
      expect(map['uid'], 'uid');
      expect(map['username'], 'username');
      expect(map['phoneNumber'], 'phoneNumber');
      expect(map['firstName'], 'firstName');
      expect(map['lastName'], 'lastName');
      expect(map['address'],
          {'street': 'street', 'country': 'country', 'city': 'city'});
      expect(map['photoUrl'], 'photoUrl');
    });

    test('fromMap() should create a new UserProfileModel instance from a map',
        () {
      // Arrange
      final map = {
        'uid': 'uid',
        'username': 'username',
        'phoneNumber': 'phoneNumber',
        'firstName': 'firstName',
        'lastName': 'lastName',
        'address': {'street': 'street', 'country': 'country', 'city': 'city'},
        'photoUrl': 'photoUrl',
      };

      // Act
      final userProfileModel = UserProfileModel.fromMap(map);

      // Assert
      expect(userProfileModel.uid, 'uid');
      expect(userProfileModel.username, 'username');
      expect(userProfileModel.phoneNumber, 'phoneNumber');
      expect(userProfileModel.firstName, 'firstName');
      expect(userProfileModel.lastName, 'lastName');
      expect(userProfileModel.address,
          Address(street: 'street', country: 'country', city: 'city'));
      expect(userProfileModel.photoUrl, 'photoUrl');
    });

    test('toJson() should return a JSON string representing the model', () {
      // Arrange
      final userProfileModel = UserProfileModel(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );

      // Act
      final json = userProfileModel.toJson();

      // Assert
      expect(json,
          '{"uid":"uid","username":"username","phoneNumber":"phoneNumber","firstName":"firstName","lastName":"lastName","address":{"street":"street","country":"country","city":"city"},"photoUrl":"photoUrl"}');
    });

    test(
        'fromJson() should create a new UserProfileModel instance from a JSON string',
        () {
      // Arrange
      const json = """{
        "uid": "uid",
        "username": "username",
        "phoneNumber": "phoneNumber",
        "firstName": "firstName",
        "lastName": "lastName",
        "address": {
          "street": "street",
          "country": "country",
          "city": "city"
        },
        "photoUrl": "photoUrl"
      }""";

      // Act
      final userProfileModel = UserProfileModel.fromJson(json);

      // Assert
      expect(userProfileModel.uid, 'uid');
      expect(userProfileModel.username, 'username');
      expect(userProfileModel.phoneNumber, 'phoneNumber');
      expect(userProfileModel.firstName, 'firstName');
      expect(userProfileModel.lastName, 'lastName');
      expect(userProfileModel.address,
          Address(street: 'street', country: 'country', city: 'city'));
      expect(userProfileModel.photoUrl, 'photoUrl');
    });
    test(
        'toEntity() should create a new UserProfileEntity instance from the model',
        () {
      // Arrange
      final userProfileModel = UserProfileModel(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );

      // Act
      final userProfileEntity = userProfileModel.toEntity();

      // Assert
      expect(userProfileEntity.uid, 'uid');
      expect(userProfileEntity.username, 'username');
      expect(userProfileEntity.phoneNumber, 'phoneNumber');
      expect(userProfileEntity.firstName, 'firstName');
      expect(userProfileEntity.lastName, 'lastName');
      expect(userProfileEntity.address,
          Address(street: 'street', country: 'country', city: 'city'));
      expect(userProfileEntity.photoUrl, 'photoUrl');
    });

    test(
        'fromUserParams() should create a new UserProfileModel instance from a UserParams instance',
        () {
      // Arrange
      final userParams = UserParams(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );

      // Act
      final userProfileModel = UserProfileModel.fromUserParams(userParams);

      // Assert
      expect(userProfileModel.uid, 'uid');
      expect(userProfileModel.username, 'username');
      expect(userProfileModel.phoneNumber, 'phoneNumber');
      expect(userProfileModel.firstName, 'firstName');
      expect(userProfileModel.lastName, 'lastName');
      expect(userProfileModel.address,
          Address(street: 'street', country: 'country', city: 'city'));
      expect(userProfileModel.photoUrl, 'photoUrl');
    });

    test('equatable should work as expected', () {
      // Arrange
      final userProfileModel1 = UserProfileModel(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );
      final userProfileModel2 = UserProfileModel(
        uid: 'uid',
        username: 'username',
        phoneNumber: 'phoneNumber',
        firstName: 'firstName',
        lastName: 'lastName',
        address: Address(street: 'street', country: 'country', city: 'city'),
        photoUrl: 'photoUrl',
      );

      // Assert
      expect(userProfileModel1, userProfileModel2);
      expect(userProfileModel1 == userProfileModel2, true);
    });
  });
}
