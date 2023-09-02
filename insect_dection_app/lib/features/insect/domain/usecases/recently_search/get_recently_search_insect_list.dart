import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetRecentlySearchInsectList extends UseCaseDoubleParams<InsectList,
    UserBucketParams, InsectListParams> {
  final UserInsectDataRepository _repo;

  GetRecentlySearchInsectList({required UserInsectDataRepository repo})
      : _repo = repo;

  @override
  Future<Either<Failure, InsectList>?> call(
          UserBucketParams firstParam, InsectListParams secondParam) =>
      _repo.getRecentlySearchInsectList(
        firstParam,
        secondParam,
      );
}
