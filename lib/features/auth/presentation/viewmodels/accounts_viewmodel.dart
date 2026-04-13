/// ============================================================
/// Arquivo: accounts_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// ViewModel responsavel por gerenciar estado e acoes da tela
/// de listagem de contas.
/// Implementacao inicial em formato placeholder para evolucao colaborativa.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Carregar contas via API
/// - Expor estados de loading/erro
/// - Adaptar dados para exibicao na View
/// - Converter resposta da API para modelo de exibicao
/// - Servir como base aberta para evolucao por qualquer integrante da equipe
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
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AccountsViewModel
///  -> loadAccounts()
///  -> estados publicos
///
/// AccountListItem
///  -> fromApi()
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
/// - Victor Hugo Rodrigues e José Antônio
///
/// Criado em: 07/04/2026
/// Ultima modificacao: 13/04/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor       | Descricao
/// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao inicial placeholder do ViewModel de contas e disponibilizacao para a equipe
/// 1.0.1  | 13/04/2026 | Victor Hugo Rodrigues | Assumiu autoria da tela
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:if_bank/features/auth/data/datasources/auth_remote_datasource.dart';

class AccountsViewModel extends ChangeNotifier {
  AccountsViewModel({required this.authRemoteDataSource});

  final AuthRemoteDataSource authRemoteDataSource;

  bool _isLoading = false;
  String? _errorMessage;
  List<AccountListItem> _accounts = const <AccountListItem>[];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<AccountListItem> get accounts => _accounts;

  Future<void> loadAccounts() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final data = await authRemoteDataSource.fetchAccounts();
      _accounts = data.map(AccountListItem.fromApi).toList();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class AccountListItem {
  AccountListItem({
    required this.title,
    required this.maskedNumber,
    required this.subtitle,
  });

  final String title;
  final String maskedNumber;
  final String subtitle;

  factory AccountListItem.fromApi(Map<String, dynamic> data) {
    final title =
        '${data['name'] ?? data['type_display'] ?? data['type'] ?? 'Conta'}';

    final rawNumber =
        '${data['account_number'] ?? data['number'] ?? data['agency_number'] ?? ''}';
    final digits = rawNumber.replaceAll(RegExp(r'\D'), '');
    final maskedNumber = digits.isEmpty
        ? '••••••••••'
        : digits.padLeft(10, '•').replaceRange(0, 2, '••');

    final subtitle = '${data['balance_label'] ?? data['status'] ?? 'Saldo'}';

    return AccountListItem(
      title: title,
      maskedNumber: maskedNumber,
      subtitle: subtitle,
    );
  }
}
