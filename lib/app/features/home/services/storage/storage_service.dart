import 'dart:async';

abstract class StorageService<T extends Object> {
  Future<T?> read(String key);
  Future<bool> write(String key, T value);
  Future<bool> deleteOne(String key);
  Future<bool> clear();
  FutureOr<void> dispose();
}