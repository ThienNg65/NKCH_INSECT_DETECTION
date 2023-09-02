import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixtures.dart';
import '../../../../helpers/insects/insect_domain.mocks.dart';

void main() {
  final List<InsectModel> insectModels =
      getInsectListFixture('insect_data_list.json');

  late GetBookmarkedInsectList getBookmarkedInsectList;
  late MockUserInsectDataRepository mockUserInsectDataRepository;

  late UserBucketParams userBucketParams;

  late InsectList insectList;
  late InsectListModel insectListModel;

  setUp(() {
    mockUserInsectDataRepository = MockUserInsectDataRepository();
    getBookmarkedInsectList =
        GetBookmarkedInsectList(repo: mockUserInsectDataRepository);
    insectListModel = InsectListModel(
      insects: insectModels,
    );
    userBucketParams = const UserBucketParams(
      uid: 'test_3@-uid',
      username: 'nvtt@gmail.com',
    );
    insectList = insectListModel.toEntity();
  });
  group('[Usecase]: Add favorite insect into user profile', () {
    test('should get [Insect Entity] from repository', () async {
      // arrange
      when(mockUserInsectDataRepository
              .getBookmarkedInsectList(userBucketParams))
          .thenAnswer((_) async =>
              Right<Failure, InsectList>(insectListModel.toEntity()));
      // act
      final result = await getBookmarkedInsectList(userBucketParams);
      // assert
      verify(mockUserInsectDataRepository.getBookmarkedInsectList(any));
      expect(result, equals(Right(insectList)));
    });
    test('should get [Failure] from repository', () async {
      // arrange
      when(mockUserInsectDataRepository
              .getBookmarkedInsectList(userBucketParams))
          .thenAnswer((_) async => const Left(ServerFailure()));
      // act
      final result = await getBookmarkedInsectList(userBucketParams);
      // assert
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}
