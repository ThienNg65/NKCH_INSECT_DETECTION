import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/domain/domain.dart';

class GetUserProfileList extends UseCase<List<UserProfileEntity>?, NoParams> {
  final UserProfileRepository _repo;

  GetUserProfileList({required UserProfileRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, List<UserProfileEntity>>?> call(void params) =>
      _repo.getUserProfileList();
}
