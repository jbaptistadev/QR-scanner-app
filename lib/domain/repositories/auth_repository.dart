import 'package:qr_scanner_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username);
  Future<User?> checkAuthStatus();
  Future<void> logout();
}
