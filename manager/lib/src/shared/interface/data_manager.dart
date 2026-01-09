abstract class DataManager<T> {
  Future<Map<String, dynamic>?> findById({required T dto});
  Future<List<Map<String, dynamic>>> findAll({required T dto});
  Future<void> create({required T dto});
  Future<void> update({required T dto});
  Future<void> delete({required T dto});
}
