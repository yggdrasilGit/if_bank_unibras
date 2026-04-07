// ============================================================
// Arquivo: lib/screens/register_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a interface de cadastro
// de novos usuarios.
// Esta versao segue o padrao visual da equipe e foi conectada
// ao endpoint real de cadastro da API do projeto.
//
// Responsabilidades:
// - Construir a UI da tela de cadastro.
// - Coletar dados basicos do usuario.
// - Acionar o fluxo de registro via ViewModel.
// - Encaminhar o usuario recem-cadastrado para a home.
//
// Dependencias:
// - package:flutter/material.dart
// - package:flutter_svg/svg.dart
// - package:provider/provider.dart
// - ../app/routes/app_routes.dart
// - ../core/constants/app_strings.dart
// - ../core/widgets/app_top_bar.dart
// - ../features/auth/presentation/viewmodels/register_viewmodel.dart
//
// Autor(es):
// - Francismar Alves Martins Junior
// - Caio Cesar Silva Menin
//
// Criado em: 26/03/2026
// Ultima modificacao: 30/03/2026
//
// Historico:
// Versao | Data       | Autor       | Descricao
// 1.0.0  | 26/03/2026 | Caio Menin  | Criacao da tela de cadastro
// 1.1.0  | 30/03/2026 | Hafrannio Rodrigues   | Integracao do cadastro com a API real do projeto
//
// Observacoes:
// - Estrutura visual preservada conforme o repositorio da equipe.
// - O usuario retornado pela API e enviado para a home via Navigator arguments.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app/routes/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/app_top_bar.dart';
import '../features/auth/presentation/viewmodels/register_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cpfFormatter = _CpfInputFormatter();
    final phoneFormatter = _BrazilPhoneInputFormatter();
    final birthDateFormatter = _DateInputFormatter();

    return Consumer<RegisterViewModel>(
      builder: (_, viewModel, _) {
        return Scaffold(
          appBar: const AppTopBar(
            title: 'Cadastro',
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            controller: viewModel.nameController,
                            validator: viewModel.validateName,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: 'Nome completo',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.cpfController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                              cpfFormatter,
                            ],
                            validator: viewModel.validateCpf,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: 'CPF',
                              hintText: '000.000.000-00',
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                              phoneFormatter,
                            ],
                            validator: viewModel.validatePhone,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                              hintText: '(00) 00000-0000',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.birthDateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(8),
                              birthDateFormatter,
                            ],
                            validator: viewModel.validateBirthDate,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: const InputDecoration(
                              labelText: 'Data de nascimento',
                              hintText: 'DD/MM/YYYY',
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.passwordController,
                            obscureText: viewModel.obscurePassword,
                            validator: viewModel.validatePassword,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: InputDecoration(
                              labelText: AppStrings.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: viewModel.togglePasswordVisibility,
                                icon: Icon(
                                  viewModel.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.confirmPasswordController,
                            obscureText: viewModel.obscureConfirmPassword,
                            validator: viewModel.validateConfirmPassword,
                            onChanged: (_) => viewModel.clearError(),
                            decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed:
                                    viewModel.toggleConfirmPasswordVisibility,
                                icon: Icon(
                                  viewModel.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
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
                                        await viewModel.register();
                                    if (!context.mounted || !success) {
                                      return;
                                    }

                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.home,
                                      arguments: viewModel.user,
                                    );
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
                                : const Text('Cadastrar'),
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

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
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
