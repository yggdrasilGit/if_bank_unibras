/// ============================================================
/// Arquivo: login_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Tela responsável por renderizar a interface de login do usuário.
///
///
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de login
/// - Integrar widgets
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// → Presentation (View)
///
/// Padrão:
/// → MVVM (Model-View-ViewModel)
///
/// Comunicação:
///
/// View → ViewModel (ações)
/// ViewModel → View (estado)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
/// - import 'package:flutter_svg/svg.dart';
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
///
/// ------------------------------------------------------------
///
/// Estrutura da UI:
///
/// LoginPage
///  └── Scaffold
///       └── SafeArea
///            └── Center
///                 └── Colunm
///                     └── SvgPitures
///                     └── Text
///                     └── Text
///
///
///
/// ------------------------------------------------------------
///
/// Fluxo de execução:
///
///
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
///
///
/// ------------------------------------------------------------
///
/// Feedback ao usuário:
///
///
/// ------------------------------------------------------------
///
/// Boas práticas:
///
library;

///
/// ------------------------------------------------------------
///
/// Responsividade:
///

///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// NÃO deve conter:
///
/// - Regras de negócio
/// - Chamadas diretas de API
/// - Validações complexas
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 19/03/2026
/// Última modificação: 19/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 19/03/2026 | Francismar  | Implentação da estrutua inicial
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:if_bank/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../features/auth/presentation/viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<LoginViewModel>(
      builder: (_, viewModel, __) {
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
                                    if (!context.mounted) return;
                                    if (success) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppRoutes.home,
                                      );
                                    }
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
