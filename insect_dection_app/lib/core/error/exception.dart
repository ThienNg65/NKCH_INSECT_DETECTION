/// [ServerException] is a class that implements the [Exception] interface.
/// It is used to handle server exceptions.
/// [errorMessage] is an optional parameter that contains the error message.
class ServerException implements Exception {
  final String? errorMessage;

  ServerException({this.errorMessage});
}

/// [CacheException] is a class that implements the [Exception] interface.
/// It is used to handle cache exceptions.
class CacheException implements Exception {}

/// [UnhandledException] is a class that implements the [Exception] interface.
/// It is used to handle unhandled exceptions.
class UnhandledException implements Exception {}

/// [EmptyCredentialException] is a class that extends the [ServerException] class.
/// It is used to handle exceptions related to empty credentials.
class EmptyCredentialException extends ServerException {}

/// [FirebaseErrorException] is a class that extends the [ServerException] class.
/// It is used to handle Firebase-related exceptions.
/// [errorMessage] is a required parameter that contains the error message from Firebase.
class FirebaseErrorException extends ServerException {
  FirebaseErrorException({required String errorMessage})
      : super(errorMessage: errorMessage);
}
