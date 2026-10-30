import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  const RegisterUseCase(this.repository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) =>
      repository.register(name: name, email: email, password: password);
}