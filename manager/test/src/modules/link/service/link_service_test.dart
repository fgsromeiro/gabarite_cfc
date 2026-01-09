import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockLinkRepository mockRepository;
  late LinkService service;
  late List<TBL0002> resultList;
  late FunctionLinkDTO dto;

  setUp(() {
    mockRepository = MockLinkRepository();
    service = LinkServiceImpl(repository: mockRepository);
    resultList = [TBL0002.instance()];
    dto = FunctionLinkDTO(id: 'any_id');
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('findQuestionsByNote', () {
    test('should return a list of QuestionByNote when repository returns success', () async {
      when(mockRepository.findQuestionsByNote(any)).thenAnswer((_) async => resultList);

      final result = await service.findQuestionsByNote('any_id');

      expect(result, equals(resultList));
      verify(mockRepository.findQuestionsByNote(any)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return an empty list ([]) when repository does not find questions', () async {
      when(mockRepository.findQuestionsByNote(any)).thenAnswer((_) async => []);

      final result = await service.findQuestionsByNote('any_id');

      expect(result, isEmpty);
      verify(mockRepository.findQuestionsByNote(any)).called(1);
    });

    test('should rethrow repository exception when the connection fails', () async {
      when(mockRepository.findQuestionsByNote(any)).thenThrow(ConnectionInternetErrorException());

      expect(
        () => service.findQuestionsByNote('any_id'),
        throwsA(isA<ConnectionInternetErrorException>()),
      );

      verify(mockRepository.findQuestionsByNote(any)).called(1);
    });

    test('should rethrow repository exception when there is a failure', () async {
      when(mockRepository.findQuestionsByNote(any)).thenThrow(ErrorSupabaseException());

      expect(
        () => service.findQuestionsByNote('any_id'),
        throwsA(isA<ErrorSupabaseException>()),
      );

      verify(mockRepository.findQuestionsByNote(any)).called(1);
    });
  });

  group('link', () {
    test('should link questions to a note', () async {
      when(mockRepository.link(any)).thenAnswer((_) async {});

      await service.link(dto);

      verify(mockRepository.link(any)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw ConnectionInternetErrorException when linking fails', () async {
      when(mockRepository.link(any)).thenThrow(ConnectionInternetErrorException());

      expect(
        () => service.link(dto),
        throwsA(isA<ConnectionInternetErrorException>()),
      );

      verify(mockRepository.link(any)).called(1);
    });

    test('should throw ErrorSupabaseException when linking fails', () async {
      when(mockRepository.link(any)).thenThrow(ErrorSupabaseException());

      expect(
        () => service.link(dto),
        throwsA(isA<ErrorSupabaseException>()),
      );

      verify(mockRepository.link(any)).called(1);
    });
  });
  group('removeLink', () {
    test('should unlink questions from a note', () async {
      when(mockRepository.removeLink(any)).thenAnswer((_) async {});

      await service.removeLink(dto);

      verify(mockRepository.removeLink(any)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw ConnectionInternetErrorException when unlinking fails', () async {
      when(mockRepository.removeLink(any)).thenThrow(ConnectionInternetErrorException());

      expect(
        () => service.removeLink(dto),
        throwsA(isA<ConnectionInternetErrorException>()),
      );

      verify(mockRepository.removeLink(any)).called(1);
    });

    test('should throw ErrorSupabaseException when unlinking fails', () async {
      when(mockRepository.removeLink(any)).thenThrow(ErrorSupabaseException());

      expect(
        () => service.removeLink(dto),
        throwsA(isA<ErrorSupabaseException>()),
      );

      verify(mockRepository.removeLink(any)).called(1);
    });
  });
}
