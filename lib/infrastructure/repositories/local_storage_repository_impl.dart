import 'package:qr_scanner_app/domain/datasource/local_storage_datasource.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/domain/repositories/local_storage_repository.dart';
import 'package:qr_scanner_app/infrastructure/datasources/sqlite_datasource.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl({LocalStorageDataSource? dataSource})
      : dataSource = dataSource ?? SQLiteDataSource();

  @override
  Future<User> createUser(String fullName, String username) {
    return dataSource.createUser(fullName, username);
  }

  @override
  Future<User?> findUser() {
    return dataSource.findUser();
  }

  @override
  Future<void> deleteUsers() {
    return dataSource.deleteUsers();
  }
}
