import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/global_scope/auth_bloc.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logout = context.read<AuthBloc>().logout;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR scanner'),
        actions: [
          IconButton(
              onPressed: () => logout(), icon: Icon(Icons.exit_to_app_sharp))
        ],
      ),
    );
  }
}
