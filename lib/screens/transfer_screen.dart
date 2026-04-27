// ============================================================
// Arquivo: lib/screens/transfer_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a interface de transferencia.
// Implementacao orientada a MVVM com Provider e preparada para
// evolucao futura sem acoplamento de regra de negocio na View.
//
// Responsabilidades:
// - Construir a view da transferencia.
// - Consumir estado e acoes do TransferViewModel.
// - Utilizar estilos base do AppTheme via Theme.of(context).
// - Exibir feedback visual de validacao e envio simulado.
//
// Dependencias:
// - package:flutter/material.dart
// - package:provider/provider.dart
// - ../features/auth/presentation/viewmodels/transfer_viewmodel.dart
//
// Autor(es):
// - Carlos Eduardo
//
// Criado em: 27/04/2026
// Ultima modificacao: 27/04/2026
//
// Historico:
// Versao | Data       | Autor | Descricao
// 1.0.0  | 27/04/2026 | Carlos Eduardo | Criacao inicial da tela de transferencia
//
// Observacoes:
// - A rota existe em AppRoutes para testes isolados.
// - A tela nao foi conectada em botao/menu de navegacao.
// - Fluxo de envio permanece simulado para futura integracao.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/viewmodels/transfer_viewmodel.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransferViewModel>(
      builder: (_, viewModel, __) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        final background = theme.scaffoldBackgroundColor;
        final fieldColor = theme.inputDecorationTheme.fillColor ?? scheme.surfaceVariant;
        final borderColor = scheme.outline;
        final titleStyle = theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        );
        final labelStyle = theme.textTheme.titleSmall?.copyWith(
          color: scheme.onSurface.withAlpha(170),
          fontWeight: FontWeight.w700,
        );

        return Scaffold(
          backgroundColor: background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TransferHeader(titleStyle: titleStyle, iconColor: scheme.onSurface),
                    const SizedBox(height: 16),
                    _SectionLabel('De Conta', style: labelStyle),
                    const SizedBox(height: 6),
                    _buildDropdownField(viewModel, fieldColor, borderColor, scheme.onSurface),
                    const SizedBox(height: 12),
                    _SectionLabel('Destinatario', style: labelStyle),
                    const SizedBox(height: 6),
                    _buildSearchField(viewModel, fieldColor, borderColor, scheme.onSurface),
                    const SizedBox(height: 6),
                    _RecipientsList(
                      recipients: viewModel.filteredRecipients,
                      selectedRecipient: viewModel.selectedRecipient,
                      onTapRecipient: viewModel.selectRecipient,
                      fieldColor: fieldColor,
                      borderColor: borderColor,
                    ),
                    const SizedBox(height: 12),
                    _SectionLabel('Valor', style: labelStyle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: viewModel.valueController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: viewModel.validateValue,
                      decoration: _inputDecoration(theme, 'Valor', fieldColor, borderColor),
                    ),
                    const SizedBox(height: 12),
                    _SectionLabel('Descricao', style: labelStyle),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: viewModel.descriptionController,
                      decoration: _inputDecoration(
                        theme,
                        'Descricao (opcional)',
                        fieldColor,
                        borderColor,
                      ),
                    ),
                    if (viewModel.feedbackMessage != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        viewModel.feedbackMessage!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Spacer(),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: viewModel.isSubmitting ? null : viewModel.submit,
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        child: viewModel.isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Enviar transferencia',
                                style: TextStyle(fontWeight: FontWeight.w700),
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

  Widget _buildDropdownField(
    TransferViewModel viewModel,
    Color fieldColor,
    Color borderColor,
    Color foreground,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: viewModel.originAccount,
          icon: Icon(Icons.keyboard_arrow_down, color: foreground),
          isExpanded: true,
          dropdownColor: fieldColor,
          items: viewModel.originAccounts
              .map(
                (account) => DropdownMenuItem<String>(
                  value: account.id,
                  child: Row(
                    children: [
                      Icon(Icons.credit_card_outlined, size: 18, color: foreground),
                      const SizedBox(width: 8),
                      Expanded(child: Text(account.label)),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: viewModel.setOriginAccount,
        ),
      ),
    );
  }

  Widget _buildSearchField(
    TransferViewModel viewModel,
    Color fieldColor,
    Color borderColor,
    Color foreground,
  ) {
    return SizedBox(
      height: 34,
      child: TextField(
        controller: viewModel.recipientSearchController,
        onChanged: viewModel.setRecipientSearch,
        decoration: InputDecoration(
          hintText: 'Buscar (ex.: nome, CPF)',
          hintStyle: TextStyle(
            color: foreground.withAlpha(150),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          isDense: true,
          filled: true,
          fillColor: fieldColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    ThemeData theme,
    String hint,
    Color fieldColor,
    Color borderColor,
  ) {
    final base = theme.inputDecorationTheme;
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: fieldColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(color: borderColor),
      ),
      errorBorder: base.errorBorder,
      focusedErrorBorder: base.focusedErrorBorder,
    );
  }
}

class _TransferHeader extends StatelessWidget {
  const _TransferHeader({required this.titleStyle, required this.iconColor});

  final TextStyle? titleStyle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_back, color: iconColor),
        const SizedBox(width: 14),
        Text('Transferencia', style: titleStyle),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

class _RecipientsList extends StatelessWidget {
  const _RecipientsList({
    required this.recipients,
    required this.selectedRecipient,
    required this.onTapRecipient,
    required this.fieldColor,
    required this.borderColor,
  });

  final List<TransferRecipientItem> recipients;
  final String? selectedRecipient;
  final ValueChanged<String> onTapRecipient;
  final Color fieldColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
        itemCount: recipients.length,
        itemBuilder: (_, index) {
          final item = recipients[index];
          final selected = item.name == selectedRecipient;
          return InkWell(
            onTap: () => onTapRecipient(item.name),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.account_circle_outlined, size: 24, color: onSurface),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.document,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: onSurface.withAlpha(170),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
