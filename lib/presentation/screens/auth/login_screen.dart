import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/login_form/login_form_bloc.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/login_form/login_form_provider.dart';
import 'package:qr_scanner_app/presentation/widgets/shared/custom_filled_button.dart';
import 'package:qr_scanner_app/presentation/widgets/shared/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(
                    label: const Text('Go back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              height: 150,
              width: 220,
              'assets/images/logo-login.png',
            ),
            SizedBox(
                height: size.height - 450, // 80 los dos sizebox y 100 el ícono
                width: double.infinity,
                child: const LoginFormProvider(
                  child: _LoginForm(),
                ))
          ],
        )),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginFormBloc = context.read<LoginFormBloc>();

    final loginFormState = context.watch<LoginFormBloc>();
    final username = loginFormState.state.username;
    final password = loginFormState.state.password;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 90,
          ),
          CustomTextFormField(
            label: 'Username',
            errorMessage: username.errorMessage,
            onChanged: loginFormBloc.loginUsernameChanged,
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            errorMessage: password.errorMessage,
            onChanged: loginFormBloc.loginPasswordChanged,
          ),
          const Spacer(
            flex: 2,
          ),
          CustomFilledButton(
            text: 'LOGIN',
            onPressed: () => loginFormBloc.onSubmit(),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
