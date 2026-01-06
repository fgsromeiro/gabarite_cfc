import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class CustomException implements Exception {
  final String message;
  final int statusCode;

  CustomException(this.message, this.statusCode);

  @override
  String toString() => message;
}

class ErrorSupabaseException extends CustomException {
  ErrorSupabaseException({String? message}) : super(message ?? StringConstants.getString(5), 400);
}
