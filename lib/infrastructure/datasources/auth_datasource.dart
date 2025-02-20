import 'package:qr_scanner_app/domain/datasource/auth_datasource.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/infrastructure/repositories/local_storage_repository_impl.dart';

class AuthDataSourceImpl extends AuthDatasource {
  final LocalStorageRepositoryImpl localStorageRepository =
      LocalStorageRepositoryImpl();

  @override
  Future<User?> checkAuthStatus() async {
    // This method is better for token management. In this case, I used it to expedite the short project development time.
    try {
      final user = await localStorageRepository.findUser();

      return User(
          id: user!.id, username: user.username, fullName: user.fullName);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> login(String username) async {
    try {
      final user = await localStorageRepository.findUser();

      if (user != null) {
        return User(
            id: user.id, username: user.username, fullName: user.fullName);
      }

      final newUser =
          await localStorageRepository.createUser('flutterchallenge', username);

      return newUser;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> logout() async {
    await localStorageRepository.deleteUsers();
  }
}
