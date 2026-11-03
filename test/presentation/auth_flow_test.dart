import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/data/datasources/auth_local_datasource.dart';
import 'package:myapp/data/repositories/auth_repository_impl.dart';
import 'package:myapp/domain/usecases/login_usecase.dart';
import 'package:myapp/domain/usecases/recover_password_usecase.dart';
import 'package:myapp/domain/usecases/register_usecase.dart';
import 'package:myapp/presentation/blocs/auth/auth_cubit.dart';
import 'package:myapp/presentation/routes/app_routes.dart';

Widget buildApp() {
  final repository = AuthRepositoryImpl(
    AuthLocalDataSource(
      loginDelay: const Duration(milliseconds: 300),
      registerDelay: Duration.zero,
      recoveryDelay: Duration.zero,
    ),
  );

  return BlocProvider(
    create: (_) => AuthCubit(
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      recoverPasswordUseCase: RecoverPasswordUseCase(repository),
    ),
    child: MaterialApp(
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    ),
  );
}

Future<void> login(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('login_email')),
    'demo@usermaster.com',
  );
  await tester.enterText(
    find.byKey(const Key('login_password')),
    '123456',
  );
  await tester.tap(find.text('Ingresar'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login muestra spinner y navega al dashboard', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();

    await tester.enterText(
      find.byKey(const Key('login_email')),
      'demo@usermaster.com',
    );
    await tester.enterText(
      find.byKey(const Key('login_password')),
      '123456',
    );
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Usuario Demo'), findsOneWidget);
  });

  testWidgets('logout vuelve al login', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await login(tester);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresar'), findsOneWidget);
  });
}