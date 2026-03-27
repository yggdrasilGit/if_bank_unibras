/// ============================================================
/// Arquivo: forgot_password_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// ViewModel responsável por gerenciar estado e ações da tela
/// de recuperação de senha.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Gerenciar estado de loading, erro e sucesso
/// - Validar e-mail informado
/// - Executar solicitação de recuperação via UseCase
/// - Expor mensagens para feedback na View
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// -> Presentation Layer
///
/// Papel:
/// -> ViewModel (MVVM)
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - RequestPasswordResetUseCase
/// - ValidatorService
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// ForgotPasswordViewModel
///  -> emailController
///  -> formKey
///  -> validateEmail()
///  -> requestReset()
///  -> estados públicos
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Não deve conter:
///
/// - Widgets
/// - Código de layout
/// - Chamada direta de API
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
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação do ViewModel de recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

library;

import 'package:flutter/material.dart';
import 'package:if_bank/core/services/validator_service.dart';
import 'package:if_bank/features/auth/domain/usercase/request_password_reset_usercase.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final RequestPasswordResetUseCase requestPasswordResetUseCase;
  final ValidatorService validatorService;

  ForgotPasswordViewModel({
    required this.requestPasswordResetUseCase,
    required this.validatorService,
  });

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  String? validateEmail(String? value) {
    return validatorService.validateEmail(value);
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  Future<bool> requestReset() async {
    _errorMessage = null;
    _successMessage = null;

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    _setLoading(true);
    final result = await requestPasswordResetUseCase(
      email: emailController.text.trim(),
    );
    _setLoading(false);

    if (result.isFailure) {
      _errorMessage = result.error;
      notifyListeners();
      return false;
    }

    _successMessage = result.data ?? 'Instruções enviadas com sucesso';
    notifyListeners();
    return true;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
