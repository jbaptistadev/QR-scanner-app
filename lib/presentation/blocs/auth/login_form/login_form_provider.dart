import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/global_scope/auth_bloc.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/login_form/login_form_bloc.dart';

class LoginFormProvider extends StatelessWidget {
  final Widget child;

  const LoginFormProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final loginUserCallback = context.read<AuthBloc>().loginUser;

    return BlocProvider(
      create: (_) => LoginFormBloc(loginUserCallback: loginUserCallback),
      child: child,
    );
  }
}
