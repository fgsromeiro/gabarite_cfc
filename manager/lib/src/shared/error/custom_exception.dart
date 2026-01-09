import '../export/app_export.dart';

class CustomException implements Exception {
  final String message;
  final int statusCode;

  CustomException(this.message, this.statusCode);

  @override
  String toString() {
    return message;
  }
}

class ErrorSupabaseException extends CustomException {
  ErrorSupabaseException({String? message}) : super(message ?? StringConstants.getString(5), 400);
}

class ErrorStorageException extends CustomException {
  ErrorStorageException({String? message}) : super(message ?? StringConstants.getString(6), 400);
}

class ErrorAuthSupabaseException extends CustomException {
  ErrorAuthSupabaseException({String? message}) : super(message ?? StringConstants.getString(7), 400);
}

class ConnectionInternetErrorException extends CustomException {
  ConnectionInternetErrorException({String? message}) : super(message ?? StringConstants.getString(2), 503);
}
