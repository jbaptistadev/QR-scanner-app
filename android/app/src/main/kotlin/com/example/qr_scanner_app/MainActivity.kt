package com.example.qr_scanner_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "biometric_auth"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            val biometricAuth = BiometricAuth(this)
            when (call.method) {
                "canAuthenticate" -> biometricAuth.canAuthenticate(result)
                "authenticate" -> biometricAuth.authenticate(result)
                else -> result.notImplemented()
            }
        }
    }
}