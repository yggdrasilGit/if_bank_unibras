/// ============================================================
/// Arquivo: login_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este ViewModel é responsável por gerenciar o estado e as
/// ações da tela de login.
///
/// Ele atua como intermediário entre a UI (View) e o domínio
/// (UseCase), aplicando o padrão MVVM.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Gerenciar estado da tela de login
/// - Controlar loading e erros
/// - Validar formulário
/// - Executar ação de login
/// - Notificar mudanças para a UI
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Presentation Layer
///
/// Atua como:
/// → ViewModel (MVVM)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///   → ChangeNotifier e controllers
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - LoginUseCase
///   → Executa regra de negócio de login
///
/// - ValidatorService
///   → Validação de campos
///
/// - UserEntity
///   → Representação do usuário
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginViewModel
///  ├── Controllers (email, password)
///  ├── formKey
///  ├── Estado (loading, erro, usuário)
///  ├── Validações
///  ├── Ações (login, toggle password)
///  └── notifyListeners()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - A UI interage com o ViewModel
/// - O ViewModel valida os dados
/// - Chama o UseCase
/// - Atualiza estado (loading, erro, usuário)
/// - Notifica a UI
///
/// ------------------------------------------------------------
///
/// Fluxo:
///
/// View (UI)
///   → ViewModel
///     → UseCase
///       → Repository
///         → DataSource
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separação de responsabilidades
/// - Estado isolado da UI
/// - Uso de ChangeNotifier
/// - Reutilização de validações
/// - Gerenciamento de ciclo de vida (dispose)
///
/// ------------------------------------------------------------
///
/// Estado gerenciado:
///
/// - isLoading → controla botão/loading
/// - obscurePassword → visibilidade da senha
/// - errorMessage → mensagem de erro
/// - user → usuário autenticado
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Widgets
/// - Código de layout
/// - Chamadas diretas de API
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Seu Nome
///
/// Criado em: 18/03/2026
/// Última modificação: 18/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação inicial do ViewModel de login
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:if_bank/features/auth/domain/usercase/login_usercase.dart';

import '../../../../core/services/validator_service.dart';
import '../../domain/entities/user_entity.dart';


/// ViewModel responsável pela lógica da tela de login.
class LoginViewModel extends ChangeNotifier {
  /// UseCase de login
  final LoginUseCase loginUseCase;

  /// Serviço de validação
  final ValidatorService validatorService;

  /// Construtor com injeção de dependência
  LoginViewModel({
    required this.loginUseCase,
    required this.validatorService,
  });

  /// Controllers dos campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Chave do formulário
  final formKey = GlobalKey<FormState>();

  /// Estados internos
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  UserEntity? _user;

  /// Getters públicos (expostos para a UI)
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  String? get errorMessage => _errorMessage;
  UserEntity? get user => _user;

  /// Validação de e-mail
  String? validateEmail(String? value) {
    return validatorService.validateEmail(value);
  }

  /// Validação de senha
  String? validatePassword(String? value) {
    return validatorService.validatePassword(value);
  }

  /// Alterna visibilidade da senha
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Executa login
  ///
  /// Retorna:
  /// - true → sucesso
  /// - false → erro
  Future<bool> login() async {
    /// Limpa erro anterior
    _errorMessage = null;

    /// Valida formulário
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    /// Ativa loading
    _setLoading(true);

    /// Chama UseCase
    final result = await loginUseCase(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    /// Desativa loading
    _setLoading(false);

    /// Trata erro
    if (result.isFailure) {
      _errorMessage = result.error;
      notifyListeners();
      return false;
    }

    /// Sucesso
    _user = result.data;
    notifyListeners();
    return true;
  }

  /// Limpa mensagem de erro
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Atualiza estado de loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Libera recursos dos controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}