/// ============================================================
/// Arquivo: register_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Tela responsável por renderizar a interface de cadastro
/// de novos usuários.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de cadastro
/// - Coletar dados basicos do usuario
/// - Realizar validações básicas de formulário
/// - Exibir feedback simples ao usuario
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// -> Presentation (View)
///
/// Padrao:
/// -> MVVM (Model-View-ViewModel)
///
/// Comunicação:
///
/// View -> ViewModel (ações futuras)
/// ViewModel -> View (estado futuro)
///
/// ------------------------------------------------------------
///
/// Dependencias externas:
///
/// - flutter/material.dart
/// - flutter_svg/svg.dart
///
/// ------------------------------------------------------------
///
/// Dependencias internas:
///
/// - AppRoutes
/// - AppStrings
/// - AppTopBar
///
/// ------------------------------------------------------------
///
/// Estrutura da UI:
///
/// RegisterScreen
///  -> Scaffold
///       -> AppTopBar
///       -> SafeArea
///            -> SingleChildScrollView
///                 -> Form
///                      -> Campos de cadastro
///                      -> Botao cadastrar
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
/// - StatelessWidget + Consumer<RegisterViewModel>
/// - Formulario controlado pelo RegisterViewModel
/// - Estado de loading/erro no ViewModel
///
/// ------------------------------------------------------------
///
/// Feedback ao usuario:
///
/// - Mensagens de erro por campo
/// - SnackBar de sucesso em validação
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Não deve conter:
///
/// - Regras de negócio complexas
/// - Chamadas diretas de API
/// - Lógica de autenticação
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 26/03/2026
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação da tela de cadastro
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app/routes/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/app_top_bar.dart';
import '../features/auth/presentation/viewmodels/register_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<RegisterViewModel>(
      builder: (_, viewModel, _) {
        return Scaffold(
          appBar: const AppTopBar(
            title: 'Cadastro',
            fallbackRoute: AppRoutes.loginScreen,
          ),
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
                                height: 64,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppStrings.appName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Crie sua conta',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: viewModel.nameController,
                            validator: viewModel.validateName,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: 'Nome completo',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.confirmPasswordController,
                            obscureText: viewModel.obscureConfirmPassword,
                            validator: viewModel.validateConfirmPassword,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed:
                                    viewModel.toggleConfirmPasswordVisibility,
                                icon: Icon(
                                  viewModel.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          if (viewModel.errorMessage != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: viewModel.isLoading
                                ? null
                                : () async {
                                    final success = await viewModel.register();
                                    if (!context.mounted) return;
                                    if (success) {
                                      final name =
                                          viewModel.user?.name ?? 'Usuário';
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Conta criada com sucesso, $name!',
                                          ),
                                        ),
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
                                : const Text('Cadastrar'),
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
