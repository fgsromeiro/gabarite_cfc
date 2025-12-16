import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late NetworkVerifier networkVerifier;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    networkVerifier = NetworkVerifier(networkInfo: mockNetworkInfo);
  });

  group('NetworkVerifier', () {
    test('should return nothing when there is a valid connection', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await expectLater(networkVerifier.verifyConnection(), completes);
    });

    test('should throw a ConnectionInternetErrorException when there is no connection', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      expect(
        () async => await networkVerifier.verifyConnection(),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });
  });
}
