import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/insects/insect_domain.mocks.dart';

void main() {
  late GetInsectByModelId getInsectByModelId;
  late MockInsectRepository mockInsectRepository;

  const modelId = 'IP000000000';

  late Insect insectEntity;
  late InsectModel insectModel;
  setUp(() {
    mockInsectRepository = MockInsectRepository();
    getInsectByModelId = GetInsectByModelId(repo: mockInsectRepository);

    insectModel = const InsectModel(
      modelId: 'IP000000000',
      taxonomy: TaxonomyModel(
        species: 'Cnaphalocrocis medinalis',
        genus: 'Cnaphalococis',
        family: 'Crambidae',
        order: 'Lepidoptera',
        classical: 'Insecta',
        phylum: 'Arthropoda',
        regnum: 'Animalia',
      ),
      nomenclature: NomenclatureModel(
        commonName: 'Rice Leaf Roller',
        otherName:
            'Cnaphalocrocis exigua, Sameaexigua, and Susumia exigua. A moth of the Crambidae',
        scientificName: 'Marasmia exigua/Cnaphalocrocis medinalis',
      ),
      impacts: ImpactModel(
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

    insectEntity = insectModel.toEntity();
  });
  group('[Usecase]: Get insect by model id', () {
    test('should get [Insect Entity] from repository', () async {
      // arrange
      when(mockInsectRepository.getInsectByModelId(modelId))
          .thenAnswer((_) async => Right(insectModel.toEntity()));
      // act
      final result = await getInsectByModelId(modelId);
      // assert
      verify(mockInsectRepository.getInsectByModelId(any));
      expect(result, equals(Right(insectEntity)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockInsectRepository.getInsectByModelId(any))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await getInsectByModelId(modelId);
      // assert
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
