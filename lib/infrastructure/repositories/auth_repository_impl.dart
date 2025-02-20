import 'package:qr_scanner_app/domain/datasource/auth_datasource.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/domain/repositories/auth_repository.dart';
import 'package:qr_scanner_app/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({AuthDatasource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String username, String password) {
    return dataSource.login(username, password);
  }

  @override
  Future<User> register(String username, String password, String fullName) {
    return dataSource.register(username, password, fullName);
  }
}
