import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/data/datasources/auth_local_datasource.dart';
import 'package:myapp/domain/exceptions/auth_exception.dart';

void main() {
  late AuthLocalDataSource dataSource;

  setUp(() {
    dataSource = AuthLocalDataSource(
      loginDelay: Duration.zero,
      registerDelay: Duration.zero,
      recoveryDelay: Duration.zero,
    );
  });

  test('login de usuario no registrado devuelve Usuario', () async {
    final user = await dataSource.login(
      email: 'nuevo@correo.com',
      password: '123456',
    );
    expect(user.name, 'Usuario');
    expect(user.email, 'nuevo@correo.com');
  });

  test('login demo con contraseña incorrecta lanza AuthException', () async {
    await expectLater(
      dataSource.login(
        email: 'demo@usermaster.com',
        password: 'incorrecta',
      ),
      throwsA(isA<AuthException>()),
    );
  });

  test('registro guarda el nombre para un login posterior', () async {
    await dataSource.register(
      name: 'Ana',
      email: 'ana@correo.com',
      password: 'abcdef',
    );
    final user = await dataSource.login(
      email: 'ana@correo.com',
      password: 'abcdef',
    );
    expect(user.name, 'Ana');
  });

  test('registro duplicado lanza AuthException', () async {
    await expectLater(
      dataSource.register(
        name: 'Demo',
        email: 'demo@usermaster.com',
        password: '123456',
      ),
      throwsA(isA<AuthException>()),
    );
  });
}