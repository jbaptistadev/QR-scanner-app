import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_app/config/router/app_router.dart';
import 'package:qr_scanner_app/config/theme/app_theme.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/auth_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => AuthBloc()..add(CheckAuthStatus()),
    child: Builder(
      builder: (context) {
        final authBloc = context.read<AuthBloc>();
        initializeRouter(authBloc);
        return const MyApp();
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
