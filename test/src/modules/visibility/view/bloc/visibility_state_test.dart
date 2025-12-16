import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

void main() {
  group('VisibilityStatus enum', () {
    test('should return isLoading correctly for each status', () {
      expect(VisibilityStatus.initial.isLoading, true);
      expect(VisibilityStatus.loading.isLoading, true);
      expect(VisibilityStatus.loaded.isLoading, false);
      expect(VisibilityStatus.changing.isLoading, false);
      expect(VisibilityStatus.error.isLoading, false);
    });

    test('should return isChanging correctly for each status', () {
      expect(VisibilityStatus.initial.isChanging, false);
      expect(VisibilityStatus.loading.isChanging, false);
      expect(VisibilityStatus.changing.isChanging, true);
      expect(VisibilityStatus.loaded.isChanging, false);
      expect(VisibilityStatus.error.isChanging, false);
    });
    test('should return isLoaded correctly for each status', () {
      expect(VisibilityStatus.initial.isLoaded, false);
      expect(VisibilityStatus.loading.isLoaded, false);
      expect(VisibilityStatus.changing.isLoaded, false);
      expect(VisibilityStatus.loaded.isLoaded, true);
      expect(VisibilityStatus.error.isLoaded, false);
    });
    test('should return isError correctly for each status', () {
      expect(VisibilityStatus.initial.isError, false);
      expect(VisibilityStatus.loading.isError, false);
      expect(VisibilityStatus.changing.isError, false);
      expect(VisibilityStatus.loaded.isError, false);
      expect(VisibilityStatus.error.isError, true);
    });
  });

  group('VisibilityState', () {
    test('should create initial state correctly', () {
      final state = VisibilityState.initial();

      expect(state.status, VisibilityStatus.initial);
      expect(state.questions, isEmpty);
      expect(state.errorMessage, isNull);
    });

    test('should copyWith correctly', () {
      final initial = VisibilityState.initial();
      final mockQuestions = [QuestionVisibility(questionBase: TBL0003.instance())];
      final mockMessageError = 'any_error';

      final newState = initial.copyWith(
        status: VisibilityStatus.error,
        errorMessage: mockMessageError,
        questions: mockQuestions,
      );

      expect(newState.status, VisibilityStatus.error);
      expect(newState.errorMessage, mockMessageError);
      expect(newState.questions, mockQuestions);
    });

    test('props should include all properties', () {
      final state = VisibilityState.initial();
      final props = state.props;

      expect(props.length, 3);
      expect(props[0], VisibilityStatus.initial);
      expect(props[1], isEmpty);
      expect(props[2], isNull);
    });
  });
}
