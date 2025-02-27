import 'package:flutter/services.dart';

class QRScannerPlugin {
  static const MethodChannel _channel = MethodChannel('qr_scanner');

  static Future<dynamic> scan() async {
    try {
      final dynamic result = await _channel.invokeMethod('startScanning');
      return result;
    } on PlatformException catch (e) {
      print("Error startScanning $e");
      throw Exception();
    }
  }
}
