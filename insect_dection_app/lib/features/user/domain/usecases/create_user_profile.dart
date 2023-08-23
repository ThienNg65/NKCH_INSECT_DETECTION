import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/domain/domain.dart';

class CreateUserProfile extends UseCase<UserProfileEntity, UserParams> {
  final UserProfileRepository _repo;

  CreateUserProfile({required UserProfileRepository repo}) : _repo = repo;
  @override
  Future<Either<Failure, UserProfileEntity>?> call(UserParams params) =>
      _repo.createUserProfile(params);
}
