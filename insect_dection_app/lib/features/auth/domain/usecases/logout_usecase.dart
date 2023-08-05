import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class LogOutRequested extends UseCase<void, void> {
  final AuthRepository repo;

  LogOutRequested({required this.repo});

  @override
  Future<Either<Failure, void>?> call(void params) => repo.logOut();
}
