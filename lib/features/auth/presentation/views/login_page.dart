/// ============================================================
/// Arquivo: login_page.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Tela responsável por renderizar a interface de login do usuário.
///
/// Esta view pertence à camada de apresentação (Presentation),
/// seguindo o padrão arquitetural MVVM.
///
/// Sua responsabilidade é exclusivamente visual, delegando toda
/// a lógica de negócio ao ViewModel.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de login
/// - Integrar widgets reutilizáveis (Header e Form)
/// - Exibir feedback ao usuário via SnackBar
/// - Reagir ao sucesso do login
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
/// - provider
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - LoginViewModel
/// - LoginForm
/// - LoginHeader
///
/// ------------------------------------------------------------
///
/// Estrutura da UI:
///
/// LoginPage
///  └── Scaffold
///       └── SafeArea
///            └── Center
///                 └── SingleChildScrollView
///                      └── ConstrainedBox
///                           └── Card
///                                ├── LoginHeader
///                                └── LoginForm
///
/// ------------------------------------------------------------
///
/// Fluxo de execução:
///
/// 1. Usuário preenche o formulário
/// 2. LoginForm chama ViewModel.login()
/// 3. ViewModel processa autenticação
/// 4. Resultado:
///    - Sucesso → onLoginSuccess()
///    - Erro → exibido no formulário
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
/// - Provider injeta o LoginViewModel
/// - context.read<LoginViewModel>() para ações
/// - Consumer (no LoginForm) para reatividade
///
/// ------------------------------------------------------------
///
/// Feedback ao usuário:
///
/// - SnackBar para mensagens informativas
/// - Mensagem de boas-vindas no login
///
/// ------------------------------------------------------------
///
/// Boas práticas:
///
/// - Separação de responsabilidades (SRP)
/// - Baixo acoplamento
/// - UI desacoplada da lógica
/// - Componentização de widgets
///
/// ------------------------------------------------------------
///
/// Responsividade:
///
/// - Limite de largura com ConstrainedBox
/// - Scroll para telas menores
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
/// - Seu Nome
///
/// Criado em: 17/03/2026
/// Última modificação: 17/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 17/03/2026 | Seu Nome    | Implementação inicial da tela
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_viewmodel.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Exibe uma mensagem na tela utilizando SnackBar
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Obtém o ViewModel sem escutar mudanças
    final viewModel = context.read<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Cabeçalho da tela (logo + título)
                      const LoginHeader(),

                      const SizedBox(height: 32),

                      /// Formulário de login
                      LoginForm(
                        onForgotPassword: () {
                          _showMessage(
                            context,
                            'Fluxo de recuperação em construção.',
                          );
                        },
                        onCreateAccount: () {
                          _showMessage(
                            context,
                            'Fluxo de cadastro em construção.',
                          );
                        },
                        onLoginSuccess: () {
                          final userName =
                              viewModel.user?.name ?? 'Usuário';

                          _showMessage(
                            context,
                            'Bem-vindo, $userName!',
                          );
                        },
                      ),
                    ],
                  ),
                ),
            
            ),
          ),
        ),
      ),
    );
  }
}