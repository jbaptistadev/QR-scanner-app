import 'package:qr_scanner_app/domain/datasource/key_value_storage_datasource.dart';
import 'package:qr_scanner_app/domain/repositories/key_value_storage_repository.dart';
import 'package:qr_scanner_app/infrastructure/datasources/key_value_storage_datasource.dart';

class KeyValueStorageRepositoryImpl extends KeyValueStorageRepository {
  final KeyValueStorageDatasource datasource;

  KeyValueStorageRepositoryImpl({KeyValueStorageDatasource? datasource})
      : datasource = datasource ?? KeyValueStorageDataSourceImpl();

  @override
  Future<T?> getKeyValue<T>(String key) {
    return datasource.getKeyValue(key);
  }

  @override
  Future<bool> removeKey<T>(String key) {
    return datasource.removeKey(key);
  }

  @override
  Future<bool> setKeyValue<T>(String key, T value) {
    return datasource.setKeyValue(key, value);
  }
}
