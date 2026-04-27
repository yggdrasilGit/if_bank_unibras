/// ============================================================
/// Arquivo: transfer_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// ViewModel responsavel por gerenciar estado e regras de
/// apresentacao da tela de transferencia.
/// Implementacao local, sem integracao com API, preparada para
/// evolucao futura mantendo o padrao MVVM do projeto.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Controlar campos do formulario de transferencia.
/// - Expor lista de contas de origem e destinatarios.
/// - Aplicar filtro de busca de destinatarios.
/// - Validar formulario e simular acao de envio.
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
/// Dependencias externas:
///
/// - package:flutter/material.dart
///
/// ------------------------------------------------------------
///
/// Restricoes:
///
/// Nao deve conter:
///
/// - Widgets
/// - Codigo de layout
/// - Acoplamento com Navigator
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Carlos Eduardo
///
/// Criado em: 27/04/2026
/// Ultima modificacao: 27/04/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor | Descricao
/// 1.0.0  | 27/04/2026 | Carlos Eduardo | Criacao inicial do ViewModel de transferencia
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';

class TransferViewModel extends ChangeNotifier {
  TransferViewModel() {
    _originAccount = _originAccounts.first.id;
  }

  final formKey = GlobalKey<FormState>();
  final recipientSearchController = TextEditingController();
  final valueController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<TransferAccountOption> _originAccounts = const [
    TransferAccountOption(id: 'checking', label: 'Conta Corrente'),
    TransferAccountOption(id: 'savings', label: 'Conta Poupanca'),
  ];

  final List<TransferRecipientItem> _allRecipients = const [
    TransferRecipientItem(name: 'Ana Souza', document: '***.123.***-**'),
    TransferRecipientItem(name: 'Bruno Lima', document: '***.456.***-**'),
    TransferRecipientItem(name: 'Carla Mendes', document: '***.789.***-**'),
    TransferRecipientItem(name: 'Diego Moraes', document: '***.214.***-**'),
  ];

  String _originAccount = '';
  String? _selectedRecipient;
  bool _isSubmitting = false;
  String? _feedbackMessage;

  List<TransferAccountOption> get originAccounts => _originAccounts;
  String get originAccount => _originAccount;
  String? get selectedRecipient => _selectedRecipient;
  bool get isSubmitting => _isSubmitting;
  String? get feedbackMessage => _feedbackMessage;

  List<TransferRecipientItem> get filteredRecipients {
    final query = recipientSearchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _allRecipients;
    }

    return _allRecipients.where((recipient) {
      final normalizedDocument = recipient.document.replaceAll(RegExp(r'\D'), '');
      final normalizedQuery = query.replaceAll(RegExp(r'\D'), '');
      return recipient.name.toLowerCase().contains(query) ||
          normalizedDocument.contains(normalizedQuery);
    }).toList();
  }

  void setOriginAccount(String? accountId) {
    if (accountId == null || accountId == _originAccount) {
      return;
    }
    _originAccount = accountId;
    notifyListeners();
  }

  void setRecipientSearch(String value) {
    recipientSearchController.text = value;
    recipientSearchController.selection = TextSelection.collapsed(offset: value.length);
    notifyListeners();
  }

  void selectRecipient(String name) {
    _selectedRecipient = name;
    notifyListeners();
  }

  String? validateValue(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) {
      return 'Informe o valor da transferencia';
    }

    final normalized = raw.replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed <= 0) {
      return 'Informe um valor valido';
    }

    return null;
  }

  Future<void> submit() async {
    _feedbackMessage = null;
    if (_selectedRecipient == null) {
      _feedbackMessage = 'Selecione um destinatario';
      notifyListeners();
      return;
    }

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _isSubmitting = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 500));

    _isSubmitting = false;
    _feedbackMessage = 'Transferencia pronta para integracao';
    notifyListeners();
  }

  @override
  void dispose() {
    recipientSearchController.dispose();
    valueController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}

class TransferAccountOption {
  const TransferAccountOption({required this.id, required this.label});

  final String id;
  final String label;
}

class TransferRecipientItem {
  const TransferRecipientItem({required this.name, required this.document});

  final String name;
  final String document;
}
