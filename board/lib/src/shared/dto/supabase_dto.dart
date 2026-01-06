import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class SupabaseDTO extends DTO {
  final Map<String, dynamic> data;
  final String value;
  final String column;

  const SupabaseDTO({
    required this.value,
    required this.data,
    required this.column,
    required super.table,
  });

  factory SupabaseDTO.value({required String table}) {
    return SupabaseDTO(value: '', table: table, data: {}, column: '');
  }
}
