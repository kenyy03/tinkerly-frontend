abstract class StorageService<T> {
  Future<void> save(String key, T value);
  Future<T?> get(String key);
  Future<void> remove(String key);
}
