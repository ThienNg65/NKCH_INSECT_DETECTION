import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/domain/usecases/infos/get_insect_list_by_taxonomy_rank.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixtures.dart';
import '../../../../../helpers/insects/insect_domain.mocks.dart';

void main() {
  final List<InsectModel> insectModels =
      getInsectListFixture('insect_data_list.json');

  late GetInsectsByTaxnomyRank getInsectsByTaxnomyRank;
  late MockInsectRepository mockInsectRepository;

  late InsectListFilterParams insectListFilterParams;

  late InsectList insectList;
  late InsectListModel insectListModel;

  setUp(() {
    mockInsectRepository = MockInsectRepository();
    getInsectsByTaxnomyRank =
        GetInsectsByTaxnomyRank(repo: mockInsectRepository);
    insectListModel = InsectListModel(
      currentPage: insectModels,
    );
    insectListFilterParams =
        InsectListFilterParams.defaultOption.copyWith(keyword: 'Lepidoptera');
    insectList = insectListModel.toEntity();
  });
  group('[Usecase]: Get Insects By Taxnomy Rank', () {
    test('should get [Insect List Entity] from repository', () async {
      // arrange
      when(mockInsectRepository.getInsectsByTaxnomyRank(any)).thenAnswer(
          (_) async => Right<Failure, InsectList>(insectListModel.toEntity()));
      // act
      final result = await getInsectsByTaxnomyRank(insectListFilterParams);
      // assert
      verify(mockInsectRepository.getInsectsByTaxnomyRank(any));
      expect(result, equals(Right(insectList)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockInsectRepository.getInsectsByTaxnomyRank(insectListFilterParams))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await getInsectsByTaxnomyRank(insectListFilterParams);
      // assert
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
