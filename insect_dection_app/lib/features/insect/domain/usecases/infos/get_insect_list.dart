import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class GetInitialInsectList extends UseCase<InsectList, InsectListParams> {
  final InsectRepository _repo;

  GetInitialInsectList({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(InsectListParams params) =>
      _repo.getInitialInsectList(params);
}

class GetMoreInsectList extends UseCase<InsectList, InsectListParams> {
  final InsectRepository _repo;

  GetMoreInsectList({required InsectRepository repo}) : _repo = repo;

  @override
  Future<Either<Failure, InsectList>> call(InsectListParams params) =>
      _repo.getMoreInsectList(params);
}
