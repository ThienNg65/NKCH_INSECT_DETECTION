import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({List properties = const <dynamic>[]}) : super();
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String? errorMessage;

  const ServerFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {}

class UnknownFailure extends Failure {
  final String? errorMessage;

  const UnknownFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class AuthenticatedFailure extends Failure {}

class NoResponse extends Failure {}
