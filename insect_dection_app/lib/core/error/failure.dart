import 'package:equatable/equatable.dart';

/// [Failure] is an abstract class that extends [Equatable].
/// It is used as a base class for different types of failures.
/// [errorMessage] is an optional parameter that contains the error message.
abstract class Failure extends Equatable {
  final String? errorMessage;
  const Failure({this.errorMessage, List properties = const <dynamic>[]})
      : super();
  @override
  List<Object?> get props => [errorMessage];
}

/// [ServerFailure] is a class that extends the [Failure] class.
/// It is used to handle server failures.
class ServerFailure extends Failure {
  const ServerFailure(
      {super.errorMessage = 'Something wrong occurs to server!'});
  @override
  List<Object?> get props => [errorMessage];
}

/// [CacheFailure] is a class that extends the [Failure] class.
/// It is used to handle cache failures.
class CacheFailure extends Failure {}

/// [UnknownFailure] is a class that extends the [Failure] class.
/// It is used to handle unknown failures.
class UnknownFailure extends Failure {
  const UnknownFailure({super.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

/// [AuthenticatedFailure] is a class that extends the [Failure] class.
/// It is used to handle authentication failures.
class AuthenticatedFailure extends Failure {}

/// [NoResponse] is a class that extends the [Failure] class.
/// It is used to handle no response failures.
class NoResponse extends Failure {}

/// [UserNotFoundFailure] is a class that extends the [Failure] class.
/// It is used to handle user not found failures.
class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure({super.errorMessage = 'User not found'});
  @override
  List<Object?> get props => [errorMessage];
}

/// [DataNotFoundFailure] is a class that extends the [Failure] class.
/// It is used to handle data not found failures.
class DataNotFoundFailure extends Failure {
  const DataNotFoundFailure({super.errorMessage = 'Data not found'});
  @override
  List<Object?> get props => [errorMessage];
}

/// [InvalidInputFailure] is a class that extends the [Failure] class.
/// It is used to handle invalid input failures.
class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.errorMessage = 'Invalid input'});
  @override
  List<Object?> get props => [errorMessage];
}

/// [DetectionResultFailure] is a class that extends the [Failure] class.
/// It is used to handle detection result failures.
class DetectionResultFailure extends Failure {
  const DetectionResultFailure({super.errorMessage = 'Detection input'});
  @override
  List<Object?> get props => [errorMessage];
}
