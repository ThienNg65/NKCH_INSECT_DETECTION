// TODO: add document
class ServerException implements Exception {
  final String? errorMesage;

  ServerException({this.errorMesage});
}

class CacheException implements Exception {}

class UnhandledException implements Exception {}

class EmptyCredentialException extends ServerException {}

class FirebaseErrorException extends ServerException {
  FirebaseErrorException({required String errorMesage})
      : super(errorMesage: errorMesage);
}
