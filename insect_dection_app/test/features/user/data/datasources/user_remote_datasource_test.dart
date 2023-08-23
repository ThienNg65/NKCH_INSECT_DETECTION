import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:mock_exceptions/mock_exceptions.dart';

void main() {
  group('User Profile Remote Datasource', () {
    late FakeFirebaseFirestore mockFirebaseFirestore;
    late UserProfileRemoteDatasourceImpl remoteDatasource;

    late UserParams userParams;

    setUp(() {
      mockFirebaseFirestore = FakeFirebaseFirestore();
      remoteDatasource = UserProfileRemoteDatasourceImpl(
        database: mockFirebaseFirestore,
      );

      userParams = const UserParams(
        uid: 'testUid',
        username: 'nvtt@gmail.com',
        phoneNumber: '0922245136',
        firstName: 'Insect',
        lastName: 'Dection',
        address: Address(
          street: '3/2 Street',
          city: 'Cantho',
          country: 'Vietnam',
        ),
        photoUrl: 'https://examples.com/testUid/avatar.jpg',
      );
    });

    group('Create User Profile  ', () {
      test('should create  [User Profile Model] in Firestore', () async {
        /// Act
        final result = await remoteDatasource.createUserProfile(
          userParams,
        );

        /// Asssert
        expect(result, isA<Right<Failure, UserProfileModel>>());

        // Get the data from Firestore and check if it matches the test data.
        final snapshot = await mockFirebaseFirestore
            .collection('users')
            .doc('testUid')
            .get();

        expect(snapshot.data(), equals(userParams.toMap()));
      });
      test('should return [ServerFailure] in Firestore', () async {
        /// Arrange
        final doc =
            mockFirebaseFirestore.collection('users').doc(userParams.uid);
        whenCalling(Invocation.method(#set, null))
            .on(doc)
            .thenThrow(FirebaseException(plugin: 'firestore'));

        /// Act
        final result = await remoteDatasource.createUserProfile(
          userParams,
        );

        /// Asssert
        expect(result, isA<Left<Failure, UserProfileModel>>());
        expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
      });
    });
  });
}
