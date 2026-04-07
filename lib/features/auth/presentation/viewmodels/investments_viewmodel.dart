/// ============================================================
/// Arquivo: investments_viewmodel.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// ViewModel responsavel por gerenciar estado e dados da tela
/// de investimentos.
/// Implementacao inicial em formato placeholder para evolucao colaborativa.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Expor resumo do portfolio para exibicao na View.
/// - Expor lista de ativos de forma estatica (placeholder).
/// - Servir como base aberta para evolucao por qualquer integrante da equipe.
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
/// Restricoes:
///
/// Nao deve conter:
///
/// - Widgets
/// - Codigo de layout
/// - Regras de negocio complexas
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Nao definido (placeholder aberto para contribuicao da equipe)
///
/// Criado em: 07/04/2026
/// Ultima modificacao: 07/04/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor       | Descricao
/// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao inicial placeholder do ViewModel de investimentos e disponibilizacao para a equipe
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';

class InvestmentsViewModel extends ChangeNotifier {
  final String totalPortfolio = 'R\$31.000,00';

  final List<InvestmentListItem> items = const <InvestmentListItem>[
    InvestmentListItem(
      symbol: 'B',
      title: 'Bitcoin',
      quantityLabel: '1 BTC',
      valueLabel: '\$80,00',
      changeLabel: 'change',
    ),
    InvestmentListItem(
      symbol: 'S',
      title: 'Solana',
      quantityLabel: '100 SOL',
      valueLabel: '\$00,00',
      changeLabel: '%change',
    ),
    InvestmentListItem(
      symbol: '🏢',
      title: 'FIIs',
      quantityLabel: 'Total',
      valueLabel: '\$300,00',
      changeLabel: '% change',
    ),
    InvestmentListItem(
      symbol: '📈',
      title: 'Acoes',
      quantityLabel: 'Total',
      valueLabel: '\$300,00',
      changeLabel: '% change',
    ),
  ];
}

class InvestmentListItem {
  const InvestmentListItem({
    required this.symbol,
    required this.title,
    required this.quantityLabel,
    required this.valueLabel,
    required this.changeLabel,
  });

  final String symbol;
  final String title;
  final String quantityLabel;
  final String valueLabel;
  final String changeLabel;
}
