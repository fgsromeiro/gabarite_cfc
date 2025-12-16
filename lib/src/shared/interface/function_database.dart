abstract class FunctionDatabase {
  Future<void> call({required String fn, required Map<String, dynamic> constrains});
}