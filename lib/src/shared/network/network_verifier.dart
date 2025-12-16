import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class NetworkVerifier {
  final NetworkInfo networkInfo;

  NetworkVerifier({required this.networkInfo});

  Future<void> verifyConnection() async {
    if (!await networkInfo.isConnected) {
      throw ConnectionInternetErrorException();
    }
  }
}
