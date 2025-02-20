import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner_app/presentation/widgets/shared/custom_filled_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Bienvenidos al reto Flutter',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Puedes autenticarte de dos formas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CustomFilledButton(
                text: 'HUELLA DARCTILAR',
                onPressed: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              CustomFilledButton(
                text: 'REGULAR LOGIN',
                onPressed: () => context.push('/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
