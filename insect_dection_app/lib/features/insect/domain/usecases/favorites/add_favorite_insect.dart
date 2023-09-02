import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class AddBookmarkedInsect
    extends UseCaseDoubleParams<Insect, UserBucketParams, InsectParams> {
  final UserInsectDataRepository _repo;

  AddBookmarkedInsect({required UserInsectDataRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, Insect>> call(
    UserBucketParams firstParam,
    InsectParams secondParam,
  ) =>
      _repo.addBookmarkedInsect(
        firstParam,
        secondParam,
      );
}
