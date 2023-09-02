import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  late InsectRemoteDatasourceImpl remoteDatasource;
  late FakeFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseStorage mockfirebaseStorage;

  // final _firstSize = 8;
  // final _sizeOffset = 12;

  setUp(() {
    mockFirebaseFirestore = FakeFirebaseFirestore();
    mockfirebaseStorage = MockFirebaseStorage();
    remoteDatasource = InsectRemoteDatasourceImpl(
      data: mockFirebaseFirestore,
      storage: mockfirebaseStorage,
    );
  });

  group('Get initial insect data', () {
    const modelId = 'IP000000000';

    InsectModel insectModel = const InsectModel(
      modelId: 'IP000000000',
      taxonomy: TaxonomyModel(
        species: 'Cnaphalocrocis medinalis',
        genus: 'Cnaphalococis',
        family: 'Crambidae',
        order: 'Lepidoptera',
        classic: 'Insecta',
        phylum: 'Arthropoda',
        regnum: 'Animalia',
      ),
      nomenclature: NomenclatureModel(
        commonName: 'Rice Leaf Roller',
        otherName:
            'Cnaphalocrocis exigua, Sameaexigua, and Susumia exigua. A moth of the Crambidae',
        scientificName: 'Marasmia exigua/Cnaphalocrocis medinalis',
      ),
      impacts: ImpactsModel(
          harms: 'Harm,Feeds on rice leaves, causing damage to the crop'),
      origin: '',
      predators:
          'Trathala flavoorbitalis, Trichogramma chilonis, Cotesia flavipes',
      photoUrl: '',
      identificationFeatures:
          'The caterpillar of this butterfly usually has 5 instars, with a body length of about 15-18mm when mature. The head is brown, the thorax and abdomen are initially green, then change to yellow-green and finally to reddish-brown. There are two spiral black lines on the posterior margin of the prothoracic shield, and 8 distinct black small circles on the meso- and metathorax, 6 of which are anterior and 2 are posterior.',
      lifeCycle:
          'Eggs are laid on rice leaves. Larvae hatch and feed on rice leaves, making them curl up. Larvae go through 5 instars. Pupae form on rice leaves. Adults emerge from pupae and lay eggs.',
      pestControl: '',
    );

    test('should get [Insect Model] in Firestore', () async {
      /// Arrange
      final doc = mockFirebaseFirestore
          .collection(InsectCollectionName.insects)
          .doc(modelId);
      doc.set(insectModel.toMap());

      /// Act
      final result = await remoteDatasource.getInsectByModelId(modelId);

      /// Asssert
      expect(result, isA<Right<Failure, InsectModel>>());
      expect(result, equals(Right(insectModel)));
    });

    test(
        'should return [DataNotFoundFailure] when an invalid modelId is passed',
        () async {
      // Arrange
      const invalidModelId = 'invalid_model_id';

      // Act
      final result = await remoteDatasource.getInsectByModelId(invalidModelId);

      // Assert
      expect(result, isA<Left<Failure, InsectModel>>());
      expect(result.fold((l) => l, (r) => r), isA<DataNotFoundFailure>());
    });

    // test('should return [ServerFailure] in Firestore', () async {
    //   /// Arrange
    //   final doc =
    //       mockFirebaseFirestore.collection(insectCollectionName).doc(modelId);
    //   whenCalling(Invocation.method(#get, null))
    //       .on(doc)
    //       .thenThrow(FirebaseException(plugin: 'firestore'));
    //   // when(doc.get()).thenThrow(FirebaseException(plugin: 'firestore'));

    //   /// Act
    //   final result = await remoteDatasource.getInsectByModelId(modelId);

    //   /// Asssert
    //   expect(result, isA<Left<Failure, InsectListModel>>());
    //   expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    // });
  });
}
