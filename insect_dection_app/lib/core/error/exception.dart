// TODO: add document
class ServerException implements Exception {
  final String? errorMessage;

  ServerException({this.errorMessage});
}

class CacheException implements Exception {}

class UnhandledException implements Exception {}

class EmptyCredentialException extends ServerException {}

class FirebaseErrorException extends ServerException {
  FirebaseErrorException({required String errorMessage})
      : super(errorMessage: errorMessage);
}
