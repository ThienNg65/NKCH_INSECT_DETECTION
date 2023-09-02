import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInsectBookmarkedState
    extends UseCaseDoubleParams<bool, UserBucketParams, String> {
  final UserInsectDataRepository _repo;

  GetInsectBookmarkedState({required UserInsectDataRepository repo})
      : _repo = repo;

  @override
  Future<Either<Failure, bool>> call(
    UserBucketParams firstParam,
    String secondParam,
  ) =>
      _repo.isBookmarkedInsect(
        firstParam,
        secondParam,
      );
}
