/// ============================================================
/// Arquivo: forgot_password_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// Tela responsavel por renderizar o fluxo inicial de
/// recuperacao de senha.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de recuperacao
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
/// Comunicacao:
///
/// View -> ViewModel (acoes futuras)
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
///                      -> Botao enviar instrucoes
///
/// ------------------------------------------------------------
///
/// Gerenciamento de estado:
///
/// - StatefulWidget
/// - Controller de e-mail
/// - GlobalKey de formulario
///
/// ------------------------------------------------------------
///
/// Feedback ao usuario:
///
/// - Mensagens de erro por campo
/// - SnackBar de confirmacao
///
/// ------------------------------------------------------------
///
/// Restricoes:
///
/// Nao deve conter:
///
/// - Regras de negocio complexas
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
/// Ultima modificacao: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor       | Descricao
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criacao da tela de recuperacao
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/routes/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/app_top_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final RegExp _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Recuperar senha',
        fallbackRoute: AppRoutes.loginScreen,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) {
                            return 'Informe seu e-mail';
                          }
                          if (!_emailRegex.hasMatch(email)) {
                            return 'Informe um e-mail valido';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: AppStrings.email,
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (buttonContext) => ElevatedButton(
                          onPressed: () {
                            final isValid = Form.of(buttonContext).validate();
                            if (isValid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Instruções de recuperação enviadas!',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Enviar instruções'),
                        ),
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
  }
}
