import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/global_scope/auth_bloc.dart';
import 'package:qr_scanner_app/presentation/widgets/shared/custom_filled_button.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text('Aqui podras escanear tus QR',
                  style: TextStyle(fontSize: 40)),
              CustomFilledButton(
                text: 'Escanear QR',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
