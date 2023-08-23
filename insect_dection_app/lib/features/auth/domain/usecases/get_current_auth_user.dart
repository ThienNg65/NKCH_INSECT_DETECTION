import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';


class GetCurrentAuthUserInfoStream
    implements StreamUseCase<AuthUserInfo, NoParams> {
  final AuthRepository repo;
  GetCurrentAuthUserInfoStream({required this.repo});

  @override
  Stream<Either<Failure, AuthUserInfo>> call(NoParams params) =>
      repo.userInfoState;
}
