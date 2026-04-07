/// ============================================================
/// Arquivo: edit_profile_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// ViewModel responsavel por gerenciar estado e acoes da tela
/// de edicao de perfil do usuario.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Carregar dados de perfil via API
/// - Controlar estado de loading e salvamento
/// - Gerenciar mensagens de erro/sucesso
/// - Controlar edicao por campo (caneta, check e cancelamento)
/// - Validar dados com ValidatorService antes de enviar
/// - Redirecionar para login em caso de sessao invalida
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
/// - AuthRemoteDataSource
/// - ValidatorService
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// EditProfileViewModel
///  -> controllers
///  -> loadProfile()
///  -> save()
///  -> confirmFieldEditWithValidation()
///  -> estados publicos
///
/// ------------------------------------------------------------
///
/// Restricoes:
///
/// Nao deve conter:
///
/// - Widgets
/// - Codigo de layout
/// - Acoplamento direto com componentes de UI
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Caio Menin
///
/// Criado em: 07/04/2026
/// Ultima modificacao: 07/04/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor   | Descricao
/// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao do ViewModel de edicao de perfil
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:if_bank/core/services/validator_service.dart';
import 'package:if_bank/features/auth/data/datasources/auth_remote_datasource.dart';

class EditProfileViewModel extends ChangeNotifier {
  static const fieldFullName = 'full_name';
  static const fieldEmail = 'email';
  static const fieldPhone = 'phone';
  static const fieldCpf = 'cpf';

  EditProfileViewModel({
    required this.validatorService,
    required this.authRemoteDataSource,
  });

  final ValidatorService validatorService;
  final AuthRemoteDataSource authRemoteDataSource;

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();

  bool _receivePushNotifications = true;
  bool _isLoadingProfile = false;
  bool _isSaving = false;
  bool _shouldRedirectToLogin = false;
  final Set<String> _editingFields = <String>{};
  final Map<String, String> _fieldSnapshots = <String, String>{};
  String? _errorMessage;
  String? _successMessage;

  bool get receivePushNotifications => _receivePushNotifications;
  bool get isLoadingProfile => _isLoadingProfile;
  bool get isSaving => _isSaving;
  bool get shouldRedirectToLogin => _shouldRedirectToLogin;
  bool get hasPendingFieldEdits => _editingFields.isNotEmpty;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  bool isFieldEditing(String field) => _editingFields.contains(field);

  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu nome completo';
    }
    if (value.trim().length < 3) {
      return 'Informe um nome válido';
    }
    return null;
  }

  String? validateEmail(String? value) => validatorService.validateEmail(value);

  String? validatePhone(String? value) => validatorService.validatePhone(value);

  String? validateCpf(String? value) => validatorService.validateCpf(value);

  void togglePushNotifications(bool value) {
    _receivePushNotifications = value;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void startFieldEdit(String field, String currentValue) {
    if (_editingFields.contains(field)) {
      return;
    }
    _fieldSnapshots[field] = currentValue;
    _editingFields.add(field);
    notifyListeners();
  }

  void confirmFieldEdit(String field) {
    _fieldSnapshots.remove(field);
    _editingFields.remove(field);
    notifyListeners();
  }

  Future<bool> confirmFieldEditWithValidation({
    required String field,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) async {
    final localError = validator(controller.text);
    if (localError != null) {
      _errorMessage = localError;
      notifyListeners();
      return false;
    }

    final payload = _payloadForField(field, controller.text);
    try {
      await authRemoteDataSource.patchProfile(payload);
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      if (_isUnauthorizedMessage(message)) {
        _shouldRedirectToLogin = true;
        notifyListeners();
        return false;
      }
      _errorMessage = message;
      notifyListeners();
      return false;
    }

    if (field == fieldCpf) {
      controller.text = _formatCpfFromApi(controller.text);
    }
    if (field == fieldPhone) {
      controller.text = _formatPhone(controller.text);
    }

    _successMessage = 'Campo atualizado com sucesso';
    confirmFieldEdit(field);
    return true;
  }

  void cancelFieldEdit(String field, TextEditingController controller) {
    controller.text = _fieldSnapshots[field] ?? controller.text;
    _fieldSnapshots.remove(field);
    _editingFields.remove(field);
    clearMessages();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> loadProfile() async {
    _setLoadingProfile(true);
    clearMessages();
    try {
      final data = await authRemoteDataSource.fetchProfile();
      fullNameController.text = '${data['full_name'] ?? data['name'] ?? ''}';
      emailController.text = '${data['email'] ?? ''}';
      phoneController.text = _formatPhone('${data['phone'] ?? ''}');
      cpfController.text = _formatCpfFromApi(data['cpf']);
      return true;
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      if (_isUnauthorizedMessage(message)) {
        _shouldRedirectToLogin = true;
        notifyListeners();
        return false;
      }
      _errorMessage = message;
      notifyListeners();
      return false;
    } finally {
      _setLoadingProfile(false);
    }
  }

  Future<bool> save() async {
    clearMessages();
    if (hasPendingFieldEdits) {
      _errorMessage = 'Confirme ou cancele as edições pendentes nos campos.';
      notifyListeners();
      return false;
    }
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return false;
    }

    _setSaving(true);
    try {
      await authRemoteDataSource.updateProfile(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        cpf: cpfController.text.trim(),
      );
    } catch (e) {
      _setSaving(false);
      final message = e.toString().replaceFirst('Exception: ', '');
      if (_isUnauthorizedMessage(message)) {
        _shouldRedirectToLogin = true;
        notifyListeners();
        return false;
      }
      _errorMessage = message;
      notifyListeners();
      return false;
    }
    _setSaving(false);

    _successMessage = 'Alterações salvas com sucesso';
    notifyListeners();
    return true;
  }

  void logout() {
    authRemoteDataSource.clearAuthorization();
  }

  void consumeRedirectToLogin() {
    _shouldRedirectToLogin = false;
  }

  void _setSaving(bool value) {
    _isSaving = value;
    notifyListeners();
  }

  void _setLoadingProfile(bool value) {
    _isLoadingProfile = value;
    notifyListeners();
  }

  String _formatCpf(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) {
      return value;
    }

    return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9, 11)}';
  }

  String _formatPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7, 11)}';
    }
    if (digits.length == 10) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2, 6)}-${digits.substring(6, 10)}';
    }
    return value;
  }

  String _formatCpfFromApi(dynamic rawCpf) {
    var digits = '${rawCpf ?? ''}'.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return '';
    }

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }
    if (digits.length < 11) {
      digits = digits.padLeft(11, '0');
    }

    return _formatCpf(digits);
  }

  bool _isUnauthorizedMessage(Object? message) {
    final normalized = '${message ?? ''}'.toLowerCase();
    return RegExp(r'__auth_invalid__').hasMatch(normalized) ||
        RegExp(
          r'credenciais de autentica(c|ç)(a|ã)o n(a|ã)o foram fornecidas',
        ).hasMatch(normalized) ||
        RegExp(
          r'authentication credentials were not provided',
        ).hasMatch(normalized);
  }

  Map<String, dynamic> _payloadForField(String field, String rawValue) {
    final value = rawValue.trim();
    switch (field) {
      case fieldFullName:
        return {'full_name': value};
      case fieldEmail:
        return {'email': value};
      case fieldPhone:
        return {'phone': value};
      case fieldCpf:
        return {'cpf': value.replaceAll(RegExp(r'\D'), '')};
      default:
        return {field: value};
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cpfController.dispose();
    super.dispose();
  }
}
