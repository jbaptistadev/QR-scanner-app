abstract class KeyValueStorageDatasource {
  Future<bool> setKeyValue<T>(String key, T value);
  Future<T?> getKeyValue<T>(String key);
  Future<bool> removeKey<T>(String key);
}
