import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_app/config/router/app_router.dart';
import 'package:qr_scanner_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:qr_scanner_app/infrastructure/repositories/key_value_storage_repository_impl.dart';
import 'package:qr_scanner_app/presentation/blocs/auth/global_scope/auth_bloc.dart';

class ProviderScope extends StatelessWidget {
  final Widget child;

  const ProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl();
    final keyValueStorageRepository = KeyValueStorageRepositoryImpl();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: authRepository,
                keyValueStorageRepository: keyValueStorageRepository)
              ..add(CheckAuthStatus()),
          )
        ],
        child: Builder(
          builder: (context) {
            final authBloc = context.read<AuthBloc>();
            initializeRouter(authBloc);
            return child;
          },
        ));
  }
}
