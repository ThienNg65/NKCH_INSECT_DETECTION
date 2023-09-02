import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInsectByModelId extends UseCase<Insect, String> {
  final InsectRepository _repo;

  GetInsectByModelId({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, Insect>> call(String params) =>
      _repo.getInsectByModelId(params);
}
