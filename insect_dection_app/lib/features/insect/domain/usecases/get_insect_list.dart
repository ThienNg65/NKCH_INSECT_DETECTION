import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInsectList extends UseCase<InsectList, InsectListParams> {
  final InsectRepository _repo;

  GetInsectList({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(InsectListParams params) =>
      _repo.getInsectList(params);
}
