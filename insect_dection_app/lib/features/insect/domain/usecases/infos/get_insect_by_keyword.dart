import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInsectByKeyword extends UseCase<InsectList, InsectListFilterParams> {
  final InsectRepository _repo;

  GetInsectByKeyword({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(InsectListFilterParams params) =>
      _repo.getInsectByKeyword(params);
}
