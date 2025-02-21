import 'package:encrypt_shared_preferences/provider.dart';
import 'package:qr_scanner_app/domain/datasource/key_value_storage_datasource.dart';
import 'package:qr_scanner_app/config/constants/environment.dart';

class KeyValueStorageDataSourceImpl extends KeyValueStorageDatasource {
  Future<EncryptedSharedPreferences> getEncryptSharedPrefs() async {
    await EncryptedSharedPreferences.initialize(
        Environment.encryptedSharedPreferencesSecret);
    return EncryptedSharedPreferences.getInstance();
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final prefs = await getEncryptSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError(
            'Get not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey<T>(String key) async {
    try {
      final prefs = await getEncryptSharedPrefs();

      return await prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setKeyValue<T>(String key, T value) async {
    final prefs = await getEncryptSharedPrefs();

    switch (T) {
      case int:
        return prefs.setInt(key, value as int);
      case String:
        return prefs.setString(key, value as String);

      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
