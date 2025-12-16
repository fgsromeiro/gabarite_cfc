import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  group('Note', () {
    final note = TBL0001(
      id: '64abf5c1-e517-49d5-9777-b6094badd0b8',
      title: 'Tipo 1',
      isReference: true,
    );

    test('constructor assigns values', () {
      expect(note.id, '64abf5c1-e517-49d5-9777-b6094badd0b8');
      expect(note.title, 'Tipo 1');
      expect(note.isReference, true);
    });

    test('toMap returns correct map', () {
      expect(
        note.toMap(),
        fixture('note.json'),
      );
    });

    test('fromMap creates correct Note', () {
      final n = TBL0001.fromMap(fixture('note.json'));

      expect(n.id, '64abf5c1-e517-49d5-9777-b6094badd0b8');
      expect(n.title, 'Tipo 1');
      expect(n.isReference, true);
    });

    test('copyWith returns updated Note', () {
      final updated = note.copyWith(
        title: 'Updated',
        isReference: false,
      );
      expect(updated.id, '64abf5c1-e517-49d5-9777-b6094badd0b8');
      expect(updated.title, 'Updated');
      expect(updated.isReference, false);
    });

    test('copyWith returns same Note if no params', () {
      final copied = note.copyWith();
      expect(copied, note);
    });

    test('equality and props', () {
      final note2 = TBL0001(
        id: '64abf5c1-e517-49d5-9777-b6094badd0b8',
        title: 'Tipo 1',
        isReference: true,
      );

      expect(note, note2);
      expect(note.props, [
        '64abf5c1-e517-49d5-9777-b6094badd0b8',
        'Tipo 1',
        true,
      ]);
    });

    test('toString returns title', () {
      expect(note.toString(), 'Tipo 1');
    });
  });
}
