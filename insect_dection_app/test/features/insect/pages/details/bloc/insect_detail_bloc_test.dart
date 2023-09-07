import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/insects/insect_domain.mocks.dart';

void main() {
  // late InsectDetailBloc insectDetailBloc;
  late MockGetInsectByModelId mockGetInsectByModelId;
  late MockAddBookmarkedInsect mockAddBookmarkedInsect;
  late MockRemoveBookmarkedInsect mockRemoveBookmarkedInsect;
  late MockAddRecentlySearchInsect mockAddRecentlySearchInsect;
  late MockGetInsectBookmarkedState mockGetInsectBookmarkedState;

  late UserBucketParams userBucketParams;
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

  Insect insectEntity = insectModel.toEntity();

  setUp(() {
    mockAddRecentlySearchInsect = MockAddRecentlySearchInsect();
    mockAddBookmarkedInsect = MockAddBookmarkedInsect();
    mockGetInsectBookmarkedState = MockGetInsectBookmarkedState();
    mockGetInsectByModelId = MockGetInsectByModelId();
    mockRemoveBookmarkedInsect = MockRemoveBookmarkedInsect();

    // insectDetailBloc = InsectDetailBloc(
    //   getInsectByModelId: mockGetInsectByModelId,
    //   addBookmarkedInsect: mockAddBookmarkedInsect,
    //   addRecentlySearchInsect: mockAddRecentlySearchInsect,
    //   getInsectBookmarkedState: mockGetInsectBookmarkedState,
    //   removeBookmarkedInsect: mockRemoveBookmarkedInsect,
    // );

    userBucketParams = const UserBucketParams(
      uid: 'tUid',
      username: 'tUsername',
    );
  });

  group(
    '[Insect Detail Bloc]',
    () {
      blocTest<InsectDetailBloc, InsectDetailState>(
        'emits [getDetailInsectProcess with Loading, getDetailInsectProcess with Success] when LoadInsectDetailEvent is added',
        build: () {
          when(mockGetInsectByModelId.call(modelId)).thenAnswer(
            (_) async => Right(insectEntity),
          );
          return InsectDetailBloc(
            getInsectByModelId: mockGetInsectByModelId,
            addBookmarkedInsect: mockAddBookmarkedInsect,
            addRecentlySearchInsect: mockAddRecentlySearchInsect,
            getInsectBookmarkedState: mockGetInsectBookmarkedState,
            removeBookmarkedInsect: mockRemoveBookmarkedInsect,
          );
        },
        act: (bloc) {
          bloc.add(LoadInsectDetailEvent(
            modelId: modelId,
            userBucketParams: userBucketParams,
          ));
        },
        expect: () => [
          InsectDetailState.initial().copyWith(
            getDetailInsectProcess: const Loading(),
          ),
          InsectDetailState.initial().copyWith(
            getDetailInsectProcess: const Success(),
            insect: insectEntity,
          ),
        ],
      );
    },
  );
}
