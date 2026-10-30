import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource dataSource;
  const AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> login({required String email, required String password}) async {
    final model =
        await dataSource.login(email: email, password: password);
    return UserMapper.toEntity(model);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) =>
      dataSource.register(name: name, email: email, password: password);

  @override
  Future<void> recoverPassword(String email) =>
      dataSource.recoverPassword(email);
}