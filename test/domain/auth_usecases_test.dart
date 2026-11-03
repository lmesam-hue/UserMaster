import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/domain/entities/user.dart';
import 'package:myapp/domain/repositories/auth_repository.dart';
import 'package:myapp/domain/usecases/login_usecase.dart';
import 'package:myapp/domain/usecases/recover_password_usecase.dart';
import 'package:myapp/domain/usecases/register_usecase.dart';

class _FakeAuthRepository implements AuthRepository {
  int loginCalls = 0;
  int registerCalls = 0;
  int recoverCalls = 0;

  @override
  Future<User> login({required String email, required String password}) async {
    loginCalls++;
    return User(name: 'Usuario Demo', email: email);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    registerCalls++;
  }

  @override
  Future<void> recoverPassword(String email) async {
    recoverCalls++;
  }
}

void main() {
  late _FakeAuthRepository repository;

  setUp(() => repository = _FakeAuthRepository());

  test('LoginUseCase delega en el repositorio', () async {
    final useCase = LoginUseCase(repository);
    final user = await useCase(email: 'a@b.com', password: '123456');
    expect(user.name, 'Usuario Demo');
    expect(repository.loginCalls, 1);
  });

  test('RegisterUseCase delega en el repositorio', () async {
    final useCase = RegisterUseCase(repository);
    await useCase(name: 'Ana', email: 'ana@correo.com', password: 'abcdef');
    expect(repository.registerCalls, 1);
  });

  test('RecoverPasswordUseCase delega en el repositorio', () async {
    final useCase = RecoverPasswordUseCase(repository);
    await useCase('ana@correo.com');
    expect(repository.recoverCalls, 1);
  });
}