// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gabarite_board_cfc/src/modules/panel/models/question.dart';
import 'package:gabarite_board_cfc/src/shared/database/supabase_repository.dart';
import 'package:gabarite_board_cfc/src/shared/error/custom_exception.dart';
import 'package:gabarite_board_cfc/src/shared/network/network_info.dart';
import 'package:gabarite_board_cfc/src/shared/utils/constants/string_constantes.dart';
import 'package:gabarite_board_cfc/src/shared/utils/supabase_utils.dart';
import 'package:get_it/get_it.dart';

abstract class PanelRemoteDataSource {
  Future<List<Question>> findAllQuestions();
  Stream<Question> listenQuestion();
  Stream<bool> listenSettingDisplay();
  Future<void> dispose();
}

class PanelRemoteDataSourceImpl implements PanelRemoteDataSource {
  final SupabaseRepository supabase;
  final NetworkInfo networkInfo;

  PanelRemoteDataSourceImpl({
    required this.supabase,
    required this.networkInfo,
  });

  @override
  Future<List<Question>> findAllQuestions() async {
    try {
      throwIf(
        !await networkInfo.isConnected,
        ConnectionInternetErrorException(StringConstants.getString(7)),
      );

      final result = await supabase.findAll(table: SupabaseUtils.questionTable);

      return List.from(result.map((e) => Question.fromMap(e)).toList())
        ..sort(
          (a, b) => a.index.compareTo(b.index),
        );
    } on CustomException {
      rethrow;
    }
  }

  @override
  Stream<Question> listenQuestion() {
    try {
      return supabase
          .initializeRealtime(
        table: SupabaseUtils.questionTable,
        channelName: 'questions',
      )
          .map((data) {
        return Question.fromMap(data);
      });
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    supabase.dispose();
  }

  @override
  Stream<bool> listenSettingDisplay() {
    try {
      return supabase
          .initializeRealtime(
        table: SupabaseUtils.displayTable,
        channelName: 'display',
      )
          .map((data) {
        return data['showButtons'] as bool;
      });
    } on CustomException {
      rethrow;
    }
  }
}
