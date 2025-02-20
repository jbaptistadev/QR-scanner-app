import 'package:qr_scanner_app/domain/entities/user.dart';

abstract class LocalStorageRepository {
  Future<User> createUser(
    String fullName,
    String username,
  );

  Future<User?> findUser();
  Future<void> deleteUsers();
}
