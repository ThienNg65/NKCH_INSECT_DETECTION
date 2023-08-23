import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/domain/domain.dart';

class UpdateUserProfile extends UseCase<UserProfileEntity, UserParams> {
  final UserProfileRepository _repo;

  UpdateUserProfile({required UserProfileRepository repo}) : _repo = repo;
  @override
  Future<Either<Failure, UserProfileEntity>?> call(UserParams params) =>
      _repo.updateUserProfile(params);
}
