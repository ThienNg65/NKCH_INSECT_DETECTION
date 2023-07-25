import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({List properties = const <dynamic>[]}) : super();
}

class ServerFailure extends Failure {
  final String? errorMessage;

  const ServerFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
