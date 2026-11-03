import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/exceptions/auth_exception.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/recover_password_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final RecoverPasswordUseCase recoverPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.recoverPasswordUseCase,
  }) : super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase(email: email, password: password);
      emit(AuthAuthenticated(user));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError('Ocurrió un error inesperado'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      await registerUseCase(name: name, email: email, password: password);
      emit(const AuthRegistered());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError('Ocurrió un error inesperado'));
    }
  }

  Future<void> recoverPassword(String email) async {
    emit(const AuthLoading());
    try {
      await recoverPasswordUseCase(email);
      emit(const AuthRecoverySent());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError('Ocurrió un error inesperado'));
    }
  }

  void logout() => emit(const AuthInitial());
}