package com.example.qr_scanner_app

import android.content.Context
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executor

class BiometricAuth(private val activity: FlutterFragmentActivity) : FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel: MethodChannel
  private lateinit var executor: Executor

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "biometric_auth")
    channel.setMethodCallHandler(this)
    executor = ContextCompat.getMainExecutor(activity)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "canAuthenticate" -> canAuthenticate(result)
      "authenticate" -> authenticate(result)
      else -> result.notImplemented()
    }
  }

  fun canAuthenticate(result: MethodChannel.Result) {
    val biometricManager = BiometricManager.from(activity)
    when (biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)) {
      BiometricManager.BIOMETRIC_SUCCESS -> result.success(true)
      BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE,
      BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE,
      BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> result.success(false)
      else -> result.error("UNKNOWN_ERROR", "Unknown error occurred", null)
    }
  }

  fun authenticate(result: MethodChannel.Result) {
    val biometricManager = BiometricManager.from(activity)
    when (biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_STRONG)) {
      BiometricManager.BIOMETRIC_SUCCESS -> {
        val fragment = BiometricFragment()
        activity.supportFragmentManager.beginTransaction().add(fragment, "biometric_fragment").commitNow()

        fragment.authenticate(object : BiometricPrompt.AuthenticationCallback() {
          override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
            super.onAuthenticationError(errorCode, errString)
            result.error("AUTH_ERROR", errString.toString(), null)
          }

          override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
            super.onAuthenticationSucceeded(authResult)
            result.success(true)
          }

          override fun onAuthenticationFailed() {
            super.onAuthenticationFailed()
            result.success(false)
          }
        })
      }
      BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> result.error("NO_HARDWARE", "No biometric hardware available", null)
      BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> result.error("HW_UNAVAILABLE", "Biometric hardware is currently unavailable", null)
      BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> result.error("NONE_ENROLLED", "No biometric credentials enrolled", null)
      else -> result.error("UNKNOWN_ERROR", "Unknown error occurred", null)
    }
  }
}