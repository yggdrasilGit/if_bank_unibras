// ============================================================
// Arquivo: lib/screens/login_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a interface de login do usuario.
// O arquivo segue a base visual da equipe e foi ajustado para
// autenticar contra a API real do projeto.
//
// Responsabilidades:
// - Construir a UI da tela de login.
// - Coletar credenciais do usuario.
// - Acionar o fluxo de autenticacao via ViewModel.
// - Encaminhar o usuario autenticado para a home.
//
// Dependencias:
// - package:flutter/material.dart
// - package:flutter_svg/svg.dart
// - package:provider/provider.dart
// - ../app/routes/app_routes.dart
// - ../core/constants/app_strings.dart
// - ../features/auth/presentation/viewmodels/login_viewmodel.dart
//
// Autor(es):
// - Francismar Alves Martins Junior
//
// Criado em: 19/03/2026
// Ultima modificacao: 30/03/2026
//
// Historico:
// Versao | Data       | Autor       | Descricao
// 1.0.0  | 19/03/2026 | Francismar  | Implementacao inicial da tela de login
// 1.1.0  | 30/03/2026 | Hafrannio Rodrigues   | Integracao da tela com a API real do projeto
//
// Observacoes:
// - Estrutura visual preservada conforme o repositorio da equipe.
// - O usuario autenticado e enviado para a home via Navigator arguments.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app/routes/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../features/auth/presentation/viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<LoginViewModel>(
      builder: (_, viewModel, _) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/logo_if_bank.svg',
                                height: 68,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppStrings.appName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppStrings.loginTitle,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          TextFormField(
                            controller: viewModel.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: viewModel.validateEmail,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: AppStrings.email,
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.passwordController,
                            obscureText: viewModel.obscurePassword,
                            validator: viewModel.validatePassword,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: InputDecoration(
                              labelText: AppStrings.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: viewModel.togglePasswordVisibility,
                                icon: Icon(
                                  viewModel.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgotPassword,
                                );
                              },
                              child: const Text(AppStrings.forgotPassword),
                            ),
                          ),
                          if (viewModel.errorMessage != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: viewModel.isLoading
                                ? null
                                : () async {
                                    final success = await viewModel.login();
                                    if (!context.mounted || !success) {
                                      return;
                                    }

                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                      arguments: viewModel.user,
                                    );
                                  },
                            child: viewModel.isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(AppStrings.signIn),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.noAccount,
                                style: theme.textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.register,
                                  );
                                },
                                child: const Text(AppStrings.createAccount),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
