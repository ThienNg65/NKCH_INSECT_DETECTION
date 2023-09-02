import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetBookmarkedInsectList extends UseCase<InsectList, UserBucketParams> {
  final UserInsectDataRepository _repo;

  GetBookmarkedInsectList({required UserInsectDataRepository repo})
      : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(UserBucketParams params) =>
      _repo.getBookmarkedInsectList(params);
}
