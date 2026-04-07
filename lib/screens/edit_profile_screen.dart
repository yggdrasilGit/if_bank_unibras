// ============================================================
// Arquivo: lib/screens/edit_profile_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a interface de edicao de perfil.
// Segue o padrao visual do projeto e utiliza MVVM com Provider.
//
// Responsabilidades:
// - Exibir dados do perfil carregados pela API.
// - Permitir edicao controlada por campo (caneta, X e check).
// - Exibir feedback de erro e sucesso.
// - Oferecer acao de logout.
//
// Dependencias:
// - package:flutter/material.dart
// - package:flutter/services.dart
// - package:provider/provider.dart
// - ../app/routes/app_routes.dart
// - ../features/auth/presentation/viewmodels/edit_profile_viewmodel.dart
//
// Autor(es):
// - Caio Menin
//
// Criado em: 07/04/2026
// Ultima modificacao: 07/04/2026
//
// Historico:
// Versao | Data       | Autor   | Descricao
// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao da tela de edicao de perfil
//
// Observacoes:
// - Campos iniciam bloqueados e so entram em edicao com acao explicita.
// - Confirmacao de campo consulta backend antes de persistir estado visual.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../app/routes/app_routes.dart';
import '../features/auth/presentation/viewmodels/edit_profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _requestedOnOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_requestedOnOpen) {
      return;
    }

    _requestedOnOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<EditProfileViewModel>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneFormatter = _BrazilPhoneInputFormatter();
    final cpfFormatter = _CpfInputFormatter();

    return Consumer<EditProfileViewModel>(
      builder: (_, viewModel, _) {
        if (viewModel.shouldRedirectToLogin) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            viewModel.consumeRedirectToLogin();
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginScreen,
              (route) => false,
            );
          });
        }

        if (viewModel.isLoadingProfile) {
          return const Scaffold(
            backgroundColor: Color(0xFFE5E5E5),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFE5E5E5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFE5E5E5),
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: const Text(
              'IF Bank',
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Form(
                key: viewModel.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: const Color(0xFF2F2F2F),
                          tooltip: 'Voltar',
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Editar Perfil',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F2F2F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD2D2D2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 45,
                              color: Color(0xFF8A8A8A),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xFF333333),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE5E5E5),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Informações Pessoais',
                      style: TextStyle(
                        color: Color(0xFF737373),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _LabelledTextField(
                      label: 'Nome completo',
                      controller: viewModel.fullNameController,
                      validator: viewModel.validateFullName,
                      keyboardType: TextInputType.name,
                      onChanged: (_) => viewModel.clearMessages(),
                      isEditing: viewModel.isFieldEditing(
                        EditProfileViewModel.fieldFullName,
                      ),
                      onEditPressed: () {
                        viewModel.startFieldEdit(
                          EditProfileViewModel.fieldFullName,
                          viewModel.fullNameController.text,
                        );
                      },
                      onCancelPressed: () {
                        viewModel.cancelFieldEdit(
                          EditProfileViewModel.fieldFullName,
                          viewModel.fullNameController,
                        );
                      },
                      onConfirmPressed: () {
                        viewModel.confirmFieldEditWithValidation(
                          field: EditProfileViewModel.fieldFullName,
                          controller: viewModel.fullNameController,
                          validator: viewModel.validateFullName,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _LabelledTextField(
                      label: 'Email',
                      controller: viewModel.emailController,
                      validator: viewModel.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => viewModel.clearMessages(),
                      isEditing: viewModel.isFieldEditing(
                        EditProfileViewModel.fieldEmail,
                      ),
                      onEditPressed: () {
                        viewModel.startFieldEdit(
                          EditProfileViewModel.fieldEmail,
                          viewModel.emailController.text,
                        );
                      },
                      onCancelPressed: () {
                        viewModel.cancelFieldEdit(
                          EditProfileViewModel.fieldEmail,
                          viewModel.emailController,
                        );
                      },
                      onConfirmPressed: () {
                        viewModel.confirmFieldEditWithValidation(
                          field: EditProfileViewModel.fieldEmail,
                          controller: viewModel.emailController,
                          validator: viewModel.validateEmail,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _LabelledTextField(
                      label: 'Telefone',
                      controller: viewModel.phoneController,
                      validator: viewModel.validatePhone,
                      keyboardType: TextInputType.phone,
                      onChanged: (_) => viewModel.clearMessages(),
                      isEditing: viewModel.isFieldEditing(
                        EditProfileViewModel.fieldPhone,
                      ),
                      onEditPressed: () {
                        viewModel.startFieldEdit(
                          EditProfileViewModel.fieldPhone,
                          viewModel.phoneController.text,
                        );
                      },
                      onCancelPressed: () {
                        viewModel.cancelFieldEdit(
                          EditProfileViewModel.fieldPhone,
                          viewModel.phoneController,
                        );
                      },
                      onConfirmPressed: () {
                        viewModel.confirmFieldEditWithValidation(
                          field: EditProfileViewModel.fieldPhone,
                          controller: viewModel.phoneController,
                          validator: viewModel.validatePhone,
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        phoneFormatter,
                      ],
                    ),
                    const SizedBox(height: 12),
                    _LabelledTextField(
                      label: 'CPF',
                      controller: viewModel.cpfController,
                      validator: viewModel.validateCpf,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => viewModel.clearMessages(),
                      isEditing: viewModel.isFieldEditing(
                        EditProfileViewModel.fieldCpf,
                      ),
                      onEditPressed: () {
                        viewModel.startFieldEdit(
                          EditProfileViewModel.fieldCpf,
                          viewModel.cpfController.text,
                        );
                      },
                      onCancelPressed: () {
                        viewModel.cancelFieldEdit(
                          EditProfileViewModel.fieldCpf,
                          viewModel.cpfController,
                        );
                      },
                      onConfirmPressed: () {
                        viewModel.confirmFieldEditWithValidation(
                          field: EditProfileViewModel.fieldCpf,
                          controller: viewModel.cpfController,
                          validator: viewModel.validateCpf,
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        cpfFormatter,
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Preferências da Conta',
                      style: TextStyle(
                        color: Color(0xFF737373),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCACACA)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Notificações por push',
                              style: TextStyle(
                                color: Color(0xFF2F2F2F),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Switch(
                            value: viewModel.receivePushNotifications,
                            onChanged: viewModel.togglePushNotifications,
                          ),
                        ],
                      ),
                    ),
                    if (viewModel.errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (viewModel.successMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        viewModel.successMessage!,
                        style: const TextStyle(
                          color: Color(0xFF0E8C58),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: viewModel.isSaving
                          ? null
                          : () async {
                              await viewModel.save();
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                        backgroundColor: const Color(0xFF3A3A3A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: viewModel.isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Salvar alterações',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.maybePop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color(0xFF3A3A3A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    OutlinedButton.icon(
                      onPressed: () {
                        viewModel.logout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.loginScreen,
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Sair da conta'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF7A1F1F),
                        side: const BorderSide(color: Color(0xFFB44A4A)),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LabelledTextField extends StatelessWidget {
  const _LabelledTextField({
    required this.label,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.onChanged,
    required this.isEditing,
    required this.onEditPressed,
    required this.onCancelPressed,
    required this.onConfirmPressed,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool isEditing;
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8A8A8A))),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: !isEditing,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Color(0xFF2F2F2F)),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: const Color(0xFFE1E1E1),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 88),
            suffixIcon: isEditing
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: onCancelPressed,
                        tooltip: 'Cancelar',
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFFB44A4A),
                        ),
                      ),
                      IconButton(
                        onPressed: onConfirmPressed,
                        tooltip: 'Confirmar',
                        icon: const Icon(
                          Icons.check,
                          size: 18,
                          color: Color(0xFF0E8C58),
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: onEditPressed,
                    tooltip: 'Editar campo',
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Color(0xFF8A8A8A),
                    ),
                  ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCACACA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF989898)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB00020)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB00020)),
            ),
          ),
        ),
      ],
    );
  }
}

class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('.');
      }
      if (i == 9) {
        buffer.write('-');
      }
      buffer.write(digits[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _BrazilPhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i == 0) {
        buffer.write('(');
      }
      if (i == 2) {
        buffer.write(') ');
      }
      if (i == 7) {
        buffer.write('-');
      }
      buffer.write(digits[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
