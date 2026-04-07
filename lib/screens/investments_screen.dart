// ============================================================
// Arquivo: lib/screens/investments_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a visao de investimentos do usuario.
// Implementacao inicial em formato placeholder para evolucao colaborativa.
//
// Responsabilidades:
// - Exibir resumo do portfolio.
// - Exibir lista de ativos em cards.
// - Exibir acao inicial para adicionar ativo (placeholder).
// - Servir como base aberta para evolucao por qualquer integrante da equipe.
//
// Dependencias:
// - package:flutter/material.dart
// - package:provider/provider.dart
// - ../features/auth/presentation/viewmodels/investments_viewmodel.dart
//
// Autor(es):
// - Nao definido (placeholder aberto para contribuicao da equipe)
//
// Criado em: 07/04/2026
// Ultima modificacao: 07/04/2026
//
// Historico:
// Versao | Data       | Autor       | Descricao
// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao inicial placeholder da tela de investimentos e disponibilizacao para a equipe
//
// Observacoes:
// - Dados exibidos atualmente sao estaticos no ViewModel.
// - Integracao de investimentos reais com API permanece como evolucao futura.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/viewmodels/investments_viewmodel.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvestmentsViewModel>(
      builder: (_, viewModel, _) {
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
                color: Color(0xFF2F2F2F),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                        'Meus Investimentos',
                        style: TextStyle(
                          color: Color(0xFF2F2F2F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3E3E3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFB1B1B1)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total portfolio',
                                style: TextStyle(
                                  color: Color(0xFF5A5A5A),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                viewModel.totalPortfolio,
                                style: const TextStyle(
                                  color: Color(0xFF3E3E3E),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Icon(
                                Icons.show_chart,
                                color: Color(0xFF6A6A6A),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const SizedBox(
                          width: 100,
                          height: 70,
                          child: _MiniBarsPlaceholder(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: viewModel.items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final item = viewModel.items[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3E3E3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFB1B1B1)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD3D3D3),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item.symbol,
                                  style: const TextStyle(
                                    color: Color(0xFF3A3A3A),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        color: Color(0xFF4A4A4A),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      item.quantityLabel,
                                      style: const TextStyle(
                                        color: Color(0xFF676767),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item.valueLabel,
                                    style: const TextStyle(
                                      color: Color(0xFF4A4A4A),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    item.changeLabel,
                                    style: const TextStyle(
                                      color: Color(0xFF6F6F6F),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fluxo de adicionar ativo em construcao.'),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      side: const BorderSide(color: Color(0xFF9E9E9E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Adicionar Ativo',
                      style: TextStyle(
                        color: Color(0xFF5C5C5C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MiniBarsPlaceholder extends StatelessWidget {
  const _MiniBarsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _Bar(height: 34),
        _Bar(height: 52),
        _Bar(height: 40),
        _Bar(height: 58),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFC3C3C3),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
