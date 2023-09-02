import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;
  const Failure({this.errorMessage, List properties = const <dynamic>[]})
      : super();
  @override
  List<Object?> get props => [errorMessage];
}

class ServerFailure extends Failure {
  const ServerFailure(
      {super.errorMessage = 'Something wrong occurs to server!'});
  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {}

class UnknownFailure extends Failure {
  const UnknownFailure({super.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class AuthenticatedFailure extends Failure {}

class NoResponse extends Failure {}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({super.errorMessage = 'User not found'});
  @override
  List<Object?> get props => [errorMessage];
}

class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure({super.errorMessage = 'Data not found'});
  @override
  List<Object?> get props => [errorMessage];
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.errorMessage = 'Invalid input'});
  @override
  List<Object?> get props => [errorMessage];
}
