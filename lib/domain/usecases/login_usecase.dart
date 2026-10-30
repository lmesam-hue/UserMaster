import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  const LoginUseCase(this.repository);

  Future<User> call({required String email, required String password}) =>
      repository.login(email: email, password: password);
}