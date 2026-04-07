// ============================================================
// Arquivo: lib/screens/accounts_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela responsavel por renderizar a listagem de contas do usuario.
// Esta tela segue o padrao visual do projeto e utiliza MVVM com Provider.
// Implementacao inicial em formato placeholder para evolucao colaborativa.
//
// Responsabilidades:
// - Exibir lista de contas carregadas via API.
// - Exibir estados de loading, erro e lista vazia.
// - Encaminhar o usuario para o fluxo futuro de adicao de conta.
// - Servir como base aberta para evolucao por qualquer integrante da equipe.
//
// Dependencias:
// - package:flutter/material.dart
// - package:provider/provider.dart
// - ../features/auth/presentation/viewmodels/accounts_viewmodel.dart
//
// Autor(es):
// - Nao definido (placeholder aberto para contribuicao da equipe)
//
// Criado em: 07/04/2026
// Ultima modificacao: 07/04/2026
//
// Historico:
// Versao | Data       | Autor       | Descricao
// 1.0.0  | 07/04/2026 | Caio Menin   | Criacao inicial placeholder da tela de contas e disponibilizacao para a equipe
//
// Observacoes:
// - O botao "Adicionar Conta" esta em estado inicial (placeholder).
// - Estrutura mantida propositalmente simples para facilitar evolucao.
//
// Licenca:
// MIT License
// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/viewmodels/accounts_viewmodel.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_requested) return;
    _requested = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AccountsViewModel>().loadAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsViewModel>(
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
                        'Minhas Contas',
                        style: TextStyle(
                          color: Color(0xFF2F2F2F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _buildBody(viewModel),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fluxo de adicionar conta em construção.'),
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
                      'Adicionar Conta',
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

  Widget _buildBody(AccountsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Text(
          viewModel.errorMessage!,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (viewModel.accounts.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma conta encontrada.',
          style: TextStyle(
            color: Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: viewModel.accounts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final account = viewModel.accounts[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE3E3E3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFB1B1B1)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFD3D3D3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.credit_card_outlined,
                  size: 30,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.title,
                      style: const TextStyle(
                        color: Color(0xFF4A4A4A),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account.maskedNumber,
                      style: const TextStyle(
                        color: Color(0xFF5A5A5A),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
