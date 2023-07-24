import 'package:dartz/dartz.dart';
import 'package:insect_dection_app/core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}
