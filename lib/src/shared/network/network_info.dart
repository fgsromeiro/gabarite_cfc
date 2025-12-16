import 'package:correcao_cfc/src/shared/export/app_export.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  Future<bool> _verifyConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> get isConnected => _verifyConnection();
}
