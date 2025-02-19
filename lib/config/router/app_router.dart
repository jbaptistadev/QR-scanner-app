import 'package:go_router/go_router.dart';
import 'package:qr_scanner_app/presentation/screens/auth/check_auth_status_screen.dart';
import 'package:qr_scanner_app/presentation/screens/auth/login_screen.dart';
import 'package:qr_scanner_app/presentation/screens/auth/welcome_screen.dart';
import 'package:qr_scanner_app/presentation/screens/qr_scanner/qr-scanner_screen.dart';
import 'package:qr_scanner_app/presentation/screens/qr_scanner/qr_scanner_results_screen.dart';

final appRouter = GoRouter(initialLocation: '/splash', routes: [
  // First screen
  GoRoute(
    path: '/splash',
    builder: (context, state) => const CheckAuthStatusScreen(),
  ),

  // Auth Routes
  GoRoute(
    path: '/welcome',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),

  // QR Scanner flow
  GoRoute(
    path: '/qr_scanner',
    builder: (context, state) => const QRScannerScreen(),
  ),
  GoRoute(
    path: '/qr_scanner_results',
    builder: (context, state) => const QRScannerResultsScreen(),
  ),
]);
