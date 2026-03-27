/// ============================================================
/// Arquivo: register_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// ViewModel responsável por gerenciar estado e ações da tela
/// de cadastro de usuário.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Gerenciar estado de loading, erro e usuario
/// - Validar campos do formulario
/// - Executar ação de cadastro via UseCase
/// - Expor dados observáveis para a View
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
/// Dependencias internas:
///
/// - RegisterUseCase
/// - ValidatorService
/// - UserEntity
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// RegisterViewModel
///  -> controllers
///  -> formKey
///  -> validadores
///  -> register()
///  -> estados publicos
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
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação do ViewModel de cadastro
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

library;

import 'package:flutter/material.dart';
import 'package:if_bank/core/services/validator_service.dart';
import 'package:if_bank/features/auth/domain/entities/user_entity.dart';
import 'package:if_bank/features/auth/domain/usercase/register_usercase.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterUseCase registerUseCase;
  final ValidatorService validatorService;

  RegisterViewModel({
    required this.registerUseCase,
    required this.validatorService,
  });

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;
  UserEntity? _user;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  String? get errorMessage => _errorMessage;
  UserEntity? get user => _user;

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu nome completo';
    }
    if (value.trim().length < 3) {
      return 'Informe um nome válido';
    }
    return null;
  }

  String? validateEmail(String? value) {
    return validatorService.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return validatorService.validatePassword(value);
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }
    if (value != passwordController.text) {
      return 'As senhas nao coincidem';
    }
    return null;
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> register() async {
    _errorMessage = null;

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    _setLoading(true);
    final result = await registerUseCase(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    _setLoading(false);

    if (result.isFailure) {
      _errorMessage = result.error;
      notifyListeners();
      return false;
    }

    _user = result.data;
    notifyListeners();
    return true;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
