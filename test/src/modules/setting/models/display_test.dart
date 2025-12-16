import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Display Model', () {
    test('should create a Display with showButtons true', () {
      final display = TBL0005(showButtons: true);

      expect(display.showButtons, isTrue);
      expect(display.mapperBool, equals('Habilitado'));
    });

    test('should create a Display with showButtons false', () {
      final display = TBL0005(showButtons: false);

      expect(display.showButtons, isFalse);
      expect(display.mapperBool, equals('Desabilitado'));
    });

    test('should convert a valid Map to Display with showButtons true', () {
      final map = {'showButtons': true};
      final display = TBL0005.fromMap(map);

      expect(display.showButtons, isTrue);
      expect(display.mapperBool, equals('Habilitado'));
    });

    test('should convert a valid Map to Display with showButtons false', () {
      final map = {'showButtons': false};
      final display = TBL0005.fromMap(map);

      expect(display.showButtons, isFalse);
      expect(display.mapperBool, equals('Desabilitado'));
    });

    test('should set showButtons to false when key is missing in Map', () {
      final map = <String, dynamic>{};
      final display = TBL0005.fromMap(map);

      expect(display.showButtons, isFalse);
      expect(display.mapperBool, equals('Desabilitado'));
    });

    test('should convert a Display to Map correctly (true)', () {
      final display = TBL0005(showButtons: true);
      final map = display.toMap();

      expect(map, {'showButtons': true});
    });

    test('should convert a Display to Map correctly (false)', () {
      final display = TBL0005(showButtons: false);
      final map = display.toMap();

      expect(map, {'showButtons': false});
    });

    test('should maintain consistency between toMap() and fromMap()', () {
      final original = TBL0005(showButtons: true);
      final fromMap = TBL0005.fromMap(original.toMap());

      expect(fromMap.showButtons, original.showButtons);
      expect(fromMap.mapperBool, original.mapperBool);
    });
  });
}
