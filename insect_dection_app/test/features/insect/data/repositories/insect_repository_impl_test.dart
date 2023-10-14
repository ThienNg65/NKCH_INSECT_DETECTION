import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../helpers/insects/insect_domain.mocks.dart';

// class MockInsectRemoteDatasource extends Mock
//     implements InsectRemoteDatasource {}

void main() {
  late InsectRepositoryImpl repository;
  late MockInsectRemoteDatasource mockRemoteDatasource;
  const modelId = '123';
  const insectModel = InsectModel(
    modelId: '123',
    taxonomy: TaxonomyModel(
      species: 'Danaus plexippus',
      genus: 'Danaus',
      family: 'Nymphalidae',
      order: 'Lepidoptera',
      classical: 'Insecta',
      phylum: 'Arthropoda',
      regnum: 'Animalia',
    ),
    nomenclature: NomenclatureModel(
      commonName: 'Monarch Butterfly',
      otherName: 'Milkweed butterfly',
      scientificName: 'Danaus plexippus',
    ),
    impacts: ImpactModel(),
    origin: 'North America',
    predators: 'Birds, spiders, lizards',
    photoUrl: 'https://example.com/monarch-butterfly.jpg',
    identificationFeatures: 'Orange and black wings with white spots',
    lifeCycle: 'Four stages: egg, larva, pupa, adult',
    pestControl: 'Remove milkweed plants from gardens',
    effect: 'Feeds on milkweed plants',
    harmedObject: 'Milkweed plants',
  );

  // Convert the model to an entity
  final insectEntity = insectModel.toEntity();
  setUp(() {
    mockRemoteDatasource = MockInsectRemoteDatasource();
    repository = InsectRepositoryImpl(remoteDatasource: mockRemoteDatasource);
  });

  group('getInsectByModelId', () {
    test(
        'should return Insect when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDatasource.getInsectByModelId(any))
          .thenAnswer((_) async => const Right(insectModel));
      // act
      final result = await repository.getInsectByModelId(modelId);
      // assert
      expect(result, equals(Right(insectEntity)));
      verify(mockRemoteDatasource.getInsectByModelId(modelId));
      verifyNoMoreInteractions(mockRemoteDatasource);
    });

    test(
        'should return Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDatasource.getInsectByModelId(any))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await repository.getInsectByModelId(modelId);
      // assert
      expect(result, equals(const Left<Failure, Insect>(ServerFailure())));
      verify(mockRemoteDatasource.getInsectByModelId(modelId));
      verifyNoMoreInteractions(mockRemoteDatasource);
    });
  });

  // TODO: Add similar tests for other methods in the repository.
}
