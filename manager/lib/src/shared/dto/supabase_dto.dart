class SupabaseDTO {
  final Map<String, dynamic> data;
  final String value;
  final String table;
  final String column;

  SupabaseDTO({
    required this.value,
    required this.table,
    required this.data,
    required this.column,
  });

  factory SupabaseDTO.value({required String table}) {
    return SupabaseDTO(value: '', table: table, data: {}, column: '');
  }
}
