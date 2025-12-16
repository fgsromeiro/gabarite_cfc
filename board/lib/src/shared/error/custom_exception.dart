class CustomException implements Exception {
  final String message;
  final int statusCode;

  CustomException(this.message, this.statusCode);

  @override
  String toString() {
    return 'Exception: $statusCode: $message';
  }
}

class ConnectionInternetErrorException extends CustomException {
  ConnectionInternetErrorException(String message) : super(message, 503);
}

class ErrorSupabaseException extends CustomException {
  ErrorSupabaseException(String message) : super(message, 400);
}
