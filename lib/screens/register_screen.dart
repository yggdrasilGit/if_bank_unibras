/// ============================================================
/// Arquivo: register_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// Tela responsavel por renderizar a interface de cadastro
/// de novos usuarios.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Construir a UI da tela de cadastro
/// - Coletar dados basicos do usuario
/// - Realizar validacoes basicas de formulario
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
/// - StatefulWidget
/// - Controllers de formulario
/// - Flags de visibilidade de senha
///
/// ------------------------------------------------------------
///
/// Feedback ao usuario:
///
/// - Mensagens de erro por campo
/// - SnackBar de sucesso em validacao
///
/// ------------------------------------------------------------
///
/// Restricoes:
///
/// Nao deve conter:
///
/// - Regras de negocio complexas
/// - Chamadas diretas de API
/// - Logica de autenticacao
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
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criacao da tela de cadastro
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  static final RegExp _emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Cadastro',
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
                        controller: _nameController,
                        validator: (value) {
                          if ((value?.trim().isEmpty ?? true)) {
                            return 'Informe seu nome completo';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          final password = value?.trim() ?? '';
                          if (password.isEmpty) {
                            return 'Informe uma senha';
                          }
                          if (password.length < 6) {
                            return 'A senha deve ter ao menos 6 caracteres';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          final confirmPassword = value?.trim() ?? '';
                          if (confirmPassword.isEmpty) {
                            return 'Confirme sua senha';
                          }
                          if (confirmPassword !=
                              _passwordController.text.trim()) {
                            return 'As senhas nao coincidem';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Confirmar senha',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
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
                                    'Cadastro validado com sucesso!',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Cadastrar'),
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
