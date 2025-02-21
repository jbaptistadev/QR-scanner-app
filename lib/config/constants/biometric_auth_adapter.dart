import 'package:flutter/services.dart';

class BiometricAuthPlugin {
  static const MethodChannel _channel = MethodChannel('biometric_auth');

  static Future<bool> get canAuthenticate async {
    final bool canAuth = await _channel.invokeMethod('canAuthenticate');
    return canAuth;
  }

  static Future<bool> authenticate() async {
    try {
      final bool authenticated = await _channel.invokeMethod('authenticate');
      return authenticated;
    } on PlatformException catch (e) {
      print("Error Authenticating $e");
      return false;
    }
  }
}
