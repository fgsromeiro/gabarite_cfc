import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class SupabaseManagerImpl implements DataManager<SupabaseDTO> {
  final SupabaseClient _client;

  SupabaseManagerImpl({required SupabaseClient client}) : _client = client;

  @override
  Future<void> create({required SupabaseDTO dto}) async {
    try {
      await _client.from(dto.table).insert(dto);
      return;
    } catch (e) {
      throw ErrorSupabaseException(message: 'Erro ao criar registro: $e');
    }
  }

  @override
  Future<void> delete({required SupabaseDTO dto}) async {
    try {
      await _client.from(dto.table).delete().eq('id', dto.value);
      return;
    } catch (e) {
      throw ErrorSupabaseException(message: 'Erro ao criar registro: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> findAll({required SupabaseDTO dto}) async {
    try {
      if (dto.column.isEmpty && dto.value.isEmpty) {
        return await _client.from(dto.table).select();
      }
      return await _client.from(dto.table).select().eq(dto.column, dto.value);
    } catch (e) {
      throw ErrorSupabaseException(message: 'Erro ao buscar registros: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> findById({required SupabaseDTO dto}) async {
    try {
      if (dto.value.isEmpty) return null;

      final result = await _client.from(dto.table).select().eq(dto.column, dto.value).single();

      if (result.isEmpty) return null;

      return result;
    } catch (e) {
      throw ErrorSupabaseException(message: 'Erro ao buscar registro: $e');
    }
  }

  @override
  Future<void> update({required SupabaseDTO dto}) async {
    try {
      await _client.from(dto.table).update(dto.data).eq(dto.column, dto.value);

      return;
    } catch (e) {
      throw ErrorSupabaseException(message: 'Erro ao atualizar registro: $e');
    }
  }
}
