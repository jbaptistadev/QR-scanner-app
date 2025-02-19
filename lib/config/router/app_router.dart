import 'package:go_router/go_router.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:qr_scanner_app/presentation/screens/auth/check_auth_status_screen.dart';
import 'package:qr_scanner_app/presentation/screens/auth/login_screen.dart';
import 'package:qr_scanner_app/presentation/screens/auth/welcome_screen.dart';
import 'package:qr_scanner_app/presentation/screens/qr_scanner/qr-scanner_screen.dart';
import 'package:qr_scanner_app/presentation/screens/qr_scanner/qr_scanner_results_screen.dart';

late GoRouter appRouter;

void initializeRouter(AuthBloc authBloc) {
  // Initialize the router
  appRouter = GoRouter(
    initialLocation: '/splash',
    refreshListenable: authBloc.authStateNotifier,
    routes: [
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

      // QR Scanner Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: '/qr_scanner_results',
        builder: (context, state) => const QRScannerResultsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      final authStatus = authBloc.state.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated &&
          (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/splash')) {
        return '/';
      }

      return null;
    },
  );
}
