import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String encryptedSharedPreferencesSecret =
      dotenv.env['SHARE_PREFERENCES_SECRET'] ??
          'Unimplemented encryptedSharedPreferencesSecret';
}
