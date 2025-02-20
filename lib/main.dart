import 'package:flutter/material.dart';
import 'package:qr_scanner_app/config/constants/environment.dart';
import 'package:qr_scanner_app/config/router/app_router.dart';
import 'package:qr_scanner_app/config/theme/app_theme.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/global_scope/provider_scope.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(child: MyApp()));
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
