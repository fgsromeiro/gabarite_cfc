import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';

void main() {
  late Map<String, dynamic> baseCompetitorData;
  late TBL0006 competitor;

  TBL0006 createBaseCompetitor() {
    return TBL0006(
      id: baseCompetitorData['id'] as String,
      atual: baseCompetitorData['cf'] as String,
      official: baseCompetitorData['official'] as String,
      c1: baseCompetitorData['papiro'] as String,
      c2: baseCompetitorData['grancursos'] as String,
      c3: baseCompetitorData['oswaldo'] as String,
      c4: baseCompetitorData['estrategia'] as String,
      idNote: baseCompetitorData['idnote'] as String,
      index: baseCompetitorData['index'] as int,
    );
  }

  setUp(() {
    baseCompetitorData = fixture('competitors.json');
    competitor = createBaseCompetitor();
  });

  group('Competitor - Initialization and Equatable Tests', () {
    test('should create an instance with correct values', () {
      expect(competitor, isNotNull);
      expect(competitor.id, 'any_id');
      expect(competitor.atual, 'A');
      expect(competitor.c1, 'A');
      expect(competitor.index, 1);
    });

    test('should return true when two instances have the same values (Equatable)', () {
      final competitor1 = createBaseCompetitor();
      final competitor2 = createBaseCompetitor();

      expect(competitor1, equals(competitor2));
    });

    test('should return false when two instances have different values (Equatable)', () {
      final competitor1 = createBaseCompetitor();
      final competitor2 = TBL0006(
        id: 'any_other_id',
        atual: baseCompetitorData['cf'] as String,
        official: baseCompetitorData['official'] as String,
        c1: baseCompetitorData['papiro'] as String,
        c2: baseCompetitorData['grancursos'] as String,
        c3: baseCompetitorData['oswaldo'] as String,
        c4: baseCompetitorData['estrategia'] as String,
        idNote: baseCompetitorData['idnote'] as String,
        index: baseCompetitorData['index'] as int,
      );

      expect(competitor1, isNot(equals(competitor2)));
    });
  });

  group('Competitor - Setters Tests', () {
    test('should update the value of papiro correctly', () {
      const newValue = 'new_value';
      competitor.setC1(newValue);
      expect(competitor.c1, newValue);
    });

    test('should update the value of granCursos correctly', () {
      const newValue = 'new_value';
      competitor.setC2(newValue);
      expect(competitor.c2, newValue);
    });
    test('should update the value of estrategia correctly', () {
      const newValue = 'new_value';
      competitor.setC4(newValue);
      expect(competitor.c4, newValue);
    });

    test('should update the value of oswaldo correctly', () {
      const newValue = 'new_value';
      competitor.setC3(newValue);
      expect(competitor.c3, newValue);
    });
  });

  group('Competitor - Validation Tests (validate and isNotEmptyAll)', () {
    test('should return true when all fields are equal to cf', () {
      expect(competitor.validate, isTrue);
    });

    test('should return false when papiro is different from cf', () {
      competitor.setC1('any_other_value');
      expect(competitor.validate, isFalse);
    });

    test('should return true when all comparison fields are filled', () {
      expect(competitor.isNotEmptyAll, isTrue);
    });

    test('should return false when papiro is empty', () {
      competitor.setC1('');
      expect(competitor.isNotEmptyAll, isFalse);
    });
  });

  group('Competitor - Serialization Tests (Map/JSON)', () {
    test('toMap should return a Map with correct keys and values', () {
      final map = competitor.toMap();

      expect(map['id'], 'any_id');
      expect(map['cf'], 'A');
      expect(map['grancursos'], 'A');
      expect(map['idnote'], 'note_id');
      expect(map['index'], 1);
      expect(map.keys.length, 8);
    });

    test('fromMap should assign default values for null or missing fields', () {
      final incompleteMap = {
        'id': 'any_id',
        'cf': null,
        'papiro': null,
        'idnote': null,
        'index': null,
      };

      final competitor = TBL0006.fromMap(incompleteMap);

      expect(competitor.id, 'any_id');
      expect(competitor.atual, '');
      expect(competitor.c1, '');
      expect(competitor.c2, '');
      expect(competitor.idNote, '');
      expect(competitor.index, 0);
    });

    test('should create a Competitor from a Map', () {
      final newCompetitor = TBL0006.fromMap(baseCompetitorData);

      expect(newCompetitor, equals(competitor));
    });

    test('should create a Competitor from JSON', () {
      final jsonString = competitor.toJson();
      expect(json.decode(jsonString), isA<Map>());

      final newCompetitor = TBL0006.fromJson(jsonString);

      expect(newCompetitor, equals(competitor));
    });
  });
}
