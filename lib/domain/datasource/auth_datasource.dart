import 'package:qr_scanner_app/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String username, String password);
  Future<User> register(String username, String password, String fullName);
  Future<User> checkAuthStatus(String token);
}
