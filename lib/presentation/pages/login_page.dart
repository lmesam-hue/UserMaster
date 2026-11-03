import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_background.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../routes/app_routes.dart';
import '../widgets/auth_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current is AuthAuthenticated || current is AuthError,
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Card(
                      elevation: 8,
                      color: AppColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 8),
                              const AuthHeader(
                                title: 'UserMaster',
                                subtitle: 'Inicia sesión para continuar',
                              ),
                              const SizedBox(height: 32),
                              AppTextField(
                                inputKey: const Key('login_email'),
                                label: 'Correo electrónico',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email_outlined,
                                validator: Validators.email,
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                inputKey: const Key('login_password'),
                                label: 'Contraseña',
                                controller: _passwordController,
                                obscureText: true,
                                prefixIcon: Icons.lock_outline,
                                validator: Validators.password,
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 24),
                              PrimaryButton(
                                label: 'Ingresar',
                                isLoading: isLoading,
                                onPressed: _submit,
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgotPassword,
                                ),
                                child: const Text('¿Olvidaste tu contraseña?'),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text('¿No tienes cuenta?'),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.register,
                                    ),
                                    child: const Text('Regístrate'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Demo: demo@usermaster.com / 123456',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
