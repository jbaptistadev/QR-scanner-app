package com.example.qr_scanner_app

import android.content.Context
import android.util.Size
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.core.content.ContextCompat
import com.google.mlkit.vision.barcode.Barcode
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.barcode.BarcodeScannerOptions
import com.google.mlkit.vision.common.InputImage
import io.flutter.embedding.android.FlutterFragmentActivity
import java.util.concurrent.Executors

class QrScanner(private val activity: FlutterFragmentActivity) {

    private val cameraExecutor = Executors.newSingleThreadExecutor()

    fun startScanning(previewView: PreviewView, callback: (String?) -> Unit) {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(activity)

        cameraProviderFuture.addListener({
            val cameraProvider = cameraProviderFuture.get()

            // Configuración del análisis de imágenes
            val barcodeScanner = BarcodeScanning.getClient(BarcodeScannerOptions.Builder().setBarcodeFormats(Barcode.FORMAT_QR_CODE).build())

            val imageAnalysis = ImageAnalysis.Builder()
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .build()
                .also {
                    it.setAnalyzer(cameraExecutor) { imageProxy ->
                        val mediaImage = imageProxy.image
                        if (mediaImage != null) {
                            val inputImage = InputImage.fromMediaImage(mediaImage, imageProxy.imageInfo.rotationDegrees)
                            barcodeScanner.process(inputImage)
                                .addOnSuccessListener { barcodes ->
                                    for (barcode in barcodes) {
                                        val rawValue = barcode.rawValue
                                        callback(rawValue)
                                        return@addOnSuccessListener // Detener el escaneo después del primer QR detectado
                                    }
                                    callback(null) // No se detectó ningún QR en este frame
                                }
                                .addOnFailureListener {
                                    callback(null) // Error al escanear
                                }
                        }
                        imageProxy.close()
                    }
                }

            // Configuración de la vista previa
            val preview = Preview.Builder()
                .build()
                .also {
                    it.setSurfaceProvider(previewView.surfaceProvider)
                }

            // Vinculación de los casos de uso a la cámara
            try {
                cameraProvider.unbindAll()
                cameraProvider.bindToLifecycle(
                    activity, CameraSelector.DEFAULT_BACK_CAMERA, preview, imageAnalysis
                )
            } catch (exc: Exception) {
                // Manejar errores
            }

        }, ContextCompat.getMainExecutor(activity))
    }
}