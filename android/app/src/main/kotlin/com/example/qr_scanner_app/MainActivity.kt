package com.example.qr_scanner_app

import android.os.Bundle
import androidx.camera.view.PreviewView
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val BIOMETRIC_CHANNEL = "biometric_auth"
    private val QR_SCANNER_CHANNEL = "qr_scanner"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // BiometricAuth MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BIOMETRIC_CHANNEL).setMethodCallHandler { call, result ->
            val biometricAuth = BiometricAuth(this)
            when (call.method) {
                "canAuthenticate" -> biometricAuth.canAuthenticate(result)
                "authenticate" -> biometricAuth.authenticate(result)
                else -> result.notImplemented()
            }
        }

        // QrScanner MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, QR_SCANNER_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startScanning") {
                val previewView = PreviewView(this)
                setContentView(previewView)
                val qrScanner = QrScanner(this)
                qrScanner.startScanning(previewView) { qrResult ->
                    runOnUiThread {
                        result.success(qrResult)
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }
}