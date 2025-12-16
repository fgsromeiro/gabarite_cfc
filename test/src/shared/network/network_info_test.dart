import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfo networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);
  });

  group('NetworkInfoImpl', () {
    test('should return true when there is a Wi-Fi connection', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkInfo.isConnected;

      expect(result, isTrue);
    });

    test('should return true when there is a mobile connection', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.mobile]);

      final result = await networkInfo.isConnected;

      expect(result, isTrue);
    });

    test('should return false when there is no internet connection', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfo.isConnected;

      expect(result, isFalse);
    });

    test('should return false when a mixture of connections includes none', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [
            ConnectivityResult.wifi,
            ConnectivityResult.none,
          ]);

      final result = await networkInfo.isConnected;

      expect(result, isFalse);
    });
  });
}
