Descripción del Proyecto
Este proyecto es una aplicación Flutter que integra autenticación biométrica y escaneo de códigos QR. La aplicación está diseñada para funcionar en dispositivos Android y utiliza varias bibliotecas y plugins para proporcionar estas funcionalidades.

Características del Proyecto
Autenticación Biométrica:

Utiliza la biblioteca androidx.biometric para proporcionar autenticación biométrica.
Permite a los usuarios autenticarse utilizando huellas dactilares, reconocimiento facial o credenciales del dispositivo (PIN, patrón, contraseña).
Escaneo de Códigos QR:

Utiliza la biblioteca CameraX de Android para acceder a la cámara del dispositivo.
Utiliza la biblioteca ML Kit de Google para escanear y procesar códigos QR.
Muestra una vista previa de la cámara y detecta códigos QR en tiempo real.
Estructura del Proyecto
El proyecto está estructurado en varias partes clave:

MainActivity.kt:

Configura los canales de método (MethodChannel) para manejar las llamadas desde Flutter.
Inicializa las clases BiometricAuth y QrScanner para manejar la autenticación biométrica y el escaneo de códigos QR, respectivamente.
BiometricAuth.kt:

Maneja la autenticación biométrica utilizando la biblioteca androidx.biometric.
Proporciona métodos para verificar si el dispositivo puede autenticarse biométricamente y para iniciar el proceso de autenticación.
QrScanner.kt:

Maneja el escaneo de códigos QR utilizando CameraX y ML Kit.
Configura la vista previa de la cámara y analiza las imágenes en tiempo real para detectar códigos QR.
Flutter Code:

Proporciona la interfaz de usuario y llama a los métodos nativos a través de los canales de método (MethodChannel).
Cómo Funciona
Autenticación Biométrica:

Cuando el usuario solicita autenticarse biométricamente, Flutter llama al método canAuthenticate o authenticate a través del canal de método biometric_auth.
MainActivity maneja la llamada y delega la tarea a la clase BiometricAuth.
BiometricAuth verifica si el dispositivo puede autenticarse biométricamente y, si es posible, inicia el proceso de autenticación.
Escaneo de Códigos QR:

Cuando el usuario solicita escanear un código QR, Flutter llama al método startScanning a través del canal de método qr_scanner.
MainActivity maneja la llamada y delega la tarea a la clase QrScanner.
QrScanner configura la vista previa de la cámara y utiliza ML Kit para analizar las imágenes en tiempo real y detectar códigos QR.
Cuando se detecta un código QR, el resultado se devuelve a Flutter a través del canal de método.
