import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockSupabaseClient mockClient;
  late MockRealtimeChannel mockChannel;
  late RealtimeManager realtimeImpl;
  late SupabaseRealtimeDTO mockDto;

  setUp(() {
    mockClient = MockSupabaseClient();
    mockChannel = MockRealtimeChannel();
    realtimeImpl = SupabaseRealtimeImpl(client: mockClient);

    mockDto = SupabaseRealtimeDTO(
      channelName: 'test_channel',
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
    );

    when(mockClient.channel(any)).thenReturn(mockChannel);

    when(mockChannel.onPostgresChanges(
      event: anyNamed('event'),
      schema: anyNamed('schema'),
      table: anyNamed('table'),
      callback: anyNamed('callback'),
    )).thenReturn(mockChannel);

    when(mockChannel.subscribe()).thenReturn(mockChannel);

    when(mockChannel.unsubscribe()).thenAnswer((_) => Future.value(''));
  });

  tearDown(() {
    reset(mockClient);
    reset(mockChannel);
  });

  group('SupabaseRealtimeImpl', () {
    test('listen () should call onPostgresChanges and subscribe with the correct parameters', () {
      realtimeImpl.listen(dto: mockDto);

      verify(mockClient.channel(mockDto.channelName)).called(1);
      verify(mockChannel.onPostgresChanges(
        event: mockDto.event,
        schema: mockDto.schema,
        table: mockDto.table,
        callback: anyNamed('callback'),
      )).called(1);

      verify(mockChannel.subscribe()).called(1);
    });

    test('listen() should add new record to stream when payload is received', () async {
      final payload = PostgresChangePayload(
        eventType: PostgresChangeEvent.update,
        schema: 'public',
        table: 'messages',
        commitTimestamp: DateTime.now(),
        newRecord: {'any_id': 1, 'content': 'any_content'},
        oldRecord: {},
        errors: [],
      );

      when(mockChannel.onPostgresChanges(
        event: anyNamed('event'),
        schema: anyNamed('schema'),
        table: anyNamed('table'),
        callback: anyNamed('callback'),
      )).thenReturn(mockChannel);

      final stream = realtimeImpl.listen(dto: mockDto);

      final capturedCallback = verify(mockChannel.onPostgresChanges(
        event: anyNamed('event'),
        schema: anyNamed('schema'),
        table: anyNamed('table'),
        callback: captureThat(named: 'callback', isNotNull),
      )).captured.last as Function;

      capturedCallback(payload);

      await expectLater(stream, emits(payload.newRecord));
    });

    test('disconnect() should call unsubscribe on channel', () async {
      realtimeImpl.listen(dto: mockDto);

      await realtimeImpl.disconnect();

      verify(mockChannel.unsubscribe()).called(1);
    });

    test('disconnect() should not throw error if the channel is null', () async {
      final Future<void> future = realtimeImpl.disconnect();

      await expectLater(future, completes);
    });
  });
}
