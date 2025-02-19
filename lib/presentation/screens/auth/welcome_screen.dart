import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: FilledButton(
                    onPressed: () {},
                    child: const Text(
                      'HUELLA DACTILAR',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: FilledButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    child: const Text(
                      'REGULAR LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
