abstract class IStorageService<T> {
  Future<void> save(String key, T value);
  T? get(String key);
  Future<void> remove(String key);
}
