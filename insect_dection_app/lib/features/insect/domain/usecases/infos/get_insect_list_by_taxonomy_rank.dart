import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInsectsByTaxnomyRank
    extends UseCase<InsectList, InsectListFilterParams> {
  final InsectRepository _repo;

  GetInsectsByTaxnomyRank({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(InsectListFilterParams params) =>
      _repo.getInsectsByTaxnomyRank(params);
}
