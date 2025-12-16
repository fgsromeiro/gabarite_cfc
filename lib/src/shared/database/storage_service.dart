import '../export/app_export.dart';

abstract class StorageService {
  Future<void> setString(String key, String value);
  Future<void> setBool(String key, bool value);
  Future<void> setInt(String key, int value);
  Future<void> setDouble(String key, double value);
  void clear();
  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
}

class StorageServiceImpl implements StorageService {
  final SharedPreferences instance;

  StorageServiceImpl({
    required this.instance,
  });

  @override
  bool getBool(String key) {
    return instance.getBool(key) ?? false;
  }

  @override
  double getDouble(String key) {
    return instance.getDouble(key) ?? 0;
  }

  @override
  int getInt(String key) {
    return instance.getInt(key) ?? 0;
  }

  @override
  String getString(String key) {
    return instance.getString(key) ?? '';
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await instance.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await instance.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await instance.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    await instance.setString(key, value);
  }

  @override
  void clear() {
    instance.clear();
  }
}
