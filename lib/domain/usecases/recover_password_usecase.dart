import '../repositories/auth_repository.dart';

class RecoverPasswordUseCase {
  final AuthRepository repository;
  const RecoverPasswordUseCase(this.repository);

  Future<void> call(String email) => repository.recoverPassword(email);
}