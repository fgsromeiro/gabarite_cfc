import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockSupabaseClient mockClient;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder;
  late FunctionDatabase supabaseRpc;

  setUp(() {
    mockClient = MockSupabaseClient();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    supabaseRpc = SupabaseRpcImpl(client: mockClient);
  });

  group('SupabaseRpcImpl', () {
    test('should call the RPC method with the correct name and parameters', () async {
      when(mockClient.rpc(any, params: anyNamed('params'))).thenAnswer((_) => mockPostgrestFilterBuilder);
      when<Future<dynamic>>(
        mockPostgrestFilterBuilder.then<dynamic>(any, onError: anyNamed('onError')),
      ).thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue({});
      });

      await supabaseRpc.call(fn: 'fnName', constrains: {'key': 'value'});

      verify(mockClient.rpc('fnName', params: {'key': 'value'})).called(1);
    });

    test('should throw ErrorSupabaseException on RPC call failure', () async {
      when(mockClient.rpc(any, params: anyNamed('params'))).thenThrow(Exception('RPC server error'));

      expect(
        () => supabaseRpc.call(fn: 'fnName', constrains: {'key': 'value'}),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });
  });
}
