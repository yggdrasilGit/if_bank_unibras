/// ============================================================
/// Arquivo: forgot_password_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Tela responsável por renderizar o fluxo inicial de
/// recuperação de senha.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de recuperação
/// - Coletar e validar e-mail do usuario
/// - Exibir feedback basico de envio
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
/// ForgotPasswordScreen
///  -> Scaffold
///       -> AppTopBar
///       -> SafeArea
///            -> SingleChildScrollView
///                 -> Form
///                      -> Campo de e-mail
///                      -> Botão enviar instruções
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
/// - StatelessWidget + Consumer<ForgotPasswordViewModel>
/// - Formulario controlado pelo ForgotPasswordViewModel
/// - Estado de loading/erro/sucesso no ViewModel
///
/// ------------------------------------------------------------
///
/// Feedback ao usuario:
///
/// - Mensagens de erro por campo
/// - SnackBar de confirmação
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Não deve conter:
///
/// - Regras de negócio complexas
/// - Chamadas diretas de API
/// - Acoplamento com camada de dados
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
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação da tela de recuperação
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
import '../features/auth/presentation/viewmodels/forgot_password_viewmodel.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ForgotPasswordViewModel>(
      builder: (_, viewModel, __) {
        return Scaffold(
          appBar: const AppTopBar(
            title: 'Recuperar senha',
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
                          SvgPicture.asset(
                            'assets/images/logo_if_bank.svg',
                            height: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Esqueceu sua senha?',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Informe seu e-mail para receber as instruções de recuperação.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: viewModel.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: viewModel.validateEmail,
                            onChanged: (_) => viewModel.clearMessages(),
                            decoration: const InputDecoration(
                              labelText: AppStrings.email,
                              prefixIcon: Icon(Icons.email_outlined),
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
                                    final success =
                                        await viewModel.requestReset();
                                    if (!context.mounted) return;
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            viewModel.successMessage ??
                                                'Instrucoes enviadas!',
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
                                : const Text('Enviar instruções'),
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
