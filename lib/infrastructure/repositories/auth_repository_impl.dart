import 'package:qr_scanner_app/domain/datasource/auth_datasource.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/domain/repositories/auth_repository.dart';
import 'package:qr_scanner_app/infrastructure/datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({AuthDatasource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User?> checkAuthStatus() {
    return dataSource.checkAuthStatus();
  }

  @override
  Future<User> login(String username) {
    return dataSource.login(username);
  }

  @override
  Future<void> logout() {
    return dataSource.logout();
  }
}
