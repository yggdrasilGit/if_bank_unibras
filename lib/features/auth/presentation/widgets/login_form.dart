/// ============================================================
/// Arquivo: login_form.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este widget representa o formulário completo da tela de login.
///
/// Ele integra todos os componentes necessários para autenticação:
/// - Campo de e-mail
/// - Campo de senha
/// - Botão de login
/// - Links auxiliares (esqueci senha / criar conta)
/// - Exibição de erros
///
/// Este componente consome o LoginViewModel utilizando Provider,
/// seguindo o padrão MVVM.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Renderizar formulário de login
/// - Conectar UI ao ViewModel
/// - Exibir estados (loading, erro)
/// - Disparar ações (login, navegação)
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Presentation Layer
///
/// Atua como:
/// → UI Component (Widget)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
/// - provider
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - LoginViewModel
///   → Estado e lógica da tela
///
/// - LoginPasswordField
///   → Componente reutilizável de senha
///
/// - AppStrings
///   → Centralização de textos
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginForm
///  └── Consumer<LoginViewModel>
///       └── Form
///            ├── Email Field
///            ├── Password Field
///            ├── Forgot Password
///            ├── Error Message
///            ├── Login Button
///            └── Create Account
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Escuta mudanças do ViewModel via Consumer
/// - Atualiza UI automaticamente com notifyListeners()
/// - Executa login via ViewModel
/// - Dispara callbacks para navegação externa
///
/// ------------------------------------------------------------
///
/// Fluxo de login:
///
/// Usuário interage → Form valida → ViewModel.login()
/// → UseCase → Repository → DataSource
///
/// ------------------------------------------------------------
///
/// Callbacks:
///
/// - onForgotPassword → Navegação externa
/// - onCreateAccount → Navegação externa
/// - onLoginSuccess → Sucesso do login
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separação de responsabilidades
/// - Uso de Consumer (reatividade)
/// - Componentização (password field separado)
/// - Estado centralizado no ViewModel
/// - UI desacoplada da lógica
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido com:
///
/// - Validação em tempo real
/// - Animações de erro
/// - Integração com biometria
/// - Internacionalização (i18n)
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Regras de negócio complexas
/// - Chamadas diretas de API
/// - Estado fora do ViewModel
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 18/03/2026
/// Última modificação: 17/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Criação do formulário de login
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../viewmodels/login_viewmodel.dart';
import 'login_password_field.dart';

/// Widget responsável pelo formulário de login.
class LoginForm extends StatelessWidget {
  /// Callback ao clicar em "Esqueci minha senha"
  final VoidCallback onForgotPassword;

  /// Callback ao clicar em "Criar conta"
  final VoidCallback onCreateAccount;

  /// Callback ao sucesso no login
  final VoidCallback onLoginSuccess;

  /// Construtor do formulário
  const LoginForm({
    super.key,
    required this.onForgotPassword,
    required this.onCreateAccount,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (_, viewModel, _) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Campo de e-mail
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

              /// Espaçamento
              const SizedBox(height: 16),

              /// Campo de senha (componente separado)
              LoginPasswordField(
                controller: viewModel.passwordController,
                obscureText: viewModel.obscurePassword,
                onToggleVisibility: viewModel.togglePasswordVisibility,
                validator: viewModel.validatePassword,
              ),

              /// Espaçamento
              const SizedBox(height: 12),

              /// Botão "Esqueci minha senha"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onForgotPassword,
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),

              /// Mensagem de erro
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

              /// Espaçamento
              const SizedBox(height: 16),

              /// Botão de login
              ElevatedButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        final success = await viewModel.login();
                        if (success) {
                          onLoginSuccess();
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

              /// Espaçamento
              const SizedBox(height: 16),

              /// Seção de criação de conta
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.noAccount),
                  TextButton(
                    onPressed: onCreateAccount,
                    child: const Text(AppStrings.createAccount),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
