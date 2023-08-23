import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class AddRecentlySearchInsect extends UseCase<Insect, InsectParams> {
  final InsectRepository _repo;

  AddRecentlySearchInsect({required InsectRepository repo}) : _repo = repo;
  @override
  Future<Either<Failure, Insect>> call(InsectParams params) =>
      _repo.addRecentlySearchInsect(params);
}
