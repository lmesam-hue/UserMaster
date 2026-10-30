import '../../domain/exceptions/auth_exception.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({
    this.loginDelay = const Duration(seconds: 2),
    this.registerDelay = const Duration(milliseconds: 1500),
    this.recoveryDelay = const Duration(seconds: 1),
  });

  final Duration loginDelay;
  final Duration registerDelay;
  final Duration recoveryDelay;

  final Map<String, _StoredUser> _users = {
    'demo@usermaster.com':
        const _StoredUser(name: 'Usuario Demo', password: '123456'),
  };

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(loginDelay);
    final key = email.toLowerCase();
    final stored = _users[key];
    if (stored != null && stored.password != password) {
      throw const AuthException('Correo o contraseña incorrectos');
    }
    return UserModel(name: stored?.name ?? 'Usuario', email: key);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(registerDelay);
    final key = email.toLowerCase();
    if (_users.containsKey(key)) {
      throw const AuthException('Ese correo ya está registrado');
    }
    _users[key] = _StoredUser(name: name, password: password);
  }

  Future<void> recoverPassword(String email) async {
    await Future<void>.delayed(recoveryDelay);
  }
}

class _StoredUser {
  final String name;
  final String password;
  const _StoredUser({required this.name, required this.password});
}