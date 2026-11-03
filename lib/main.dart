import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/recover_password_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'presentation/blocs/auth/auth_cubit.dart';

void main() {
  final repository = AuthRepositoryImpl(AuthLocalDataSource());

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(repository),
        registerUseCase: RegisterUseCase(repository),
        recoverPasswordUseCase: RecoverPasswordUseCase(repository),
      ),
      child: const UserMasterApp(),
    ),
  );
}