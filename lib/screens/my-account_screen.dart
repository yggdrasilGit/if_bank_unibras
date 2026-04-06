// ============================================================
// Arquivo: my-account_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descrição:
// Este arquivo implementa a tela de "Minhas Contas" da aplicação IF Bank.
// Ele é responsável por listar as contas do usuário, permitindo visualizar
// os diferentes tipos de contas vinculadas ao seu perfil (ex: Conta Corrente,
// Poupança, etc.), além de oferecer a opção de adicionar novas contas.
//
// A tela inclui:
// - Título da seção (Minhas Contas)
// - Cards de listagem para diferentes contas (Conta Corrente, Conta Poupança, Outra Conta)
// - Ocultação dos números das contas por segurança
// - Botão para adicionar uma nova conta
//
// ------------------------------------------------------------
//
// Responsabilidades:
//
// - Exibir as contas do usuário de forma organizada
// - Diferenciar visualmente os tipos de contas
// - Fornecer um ponto de entrada para adição de novas contas
//
// ------------------------------------------------------------
//
// Arquitetura:
//
// Este arquivo pertence à camada:
// → Presentation Layer
//
// Atua como:
// → UI Screen (StatelessWidget)
//
// ------------------------------------------------------------
//
// Dependências externas:
//
// - flutter/material.dart
//   → Framework de UI do Flutter
//
// ------------------------------------------------------------
//
// Estrutura:
//
// MyAccountScreen (StatelessWidget)
//  ├── build()
//  └── _buildAccountCard()
//
// ------------------------------------------------------------
//
// Funcionamento:
//
// A tela utiliza:
// - Um layout simples e responsivo com Column e Spacer
// - Componentes customizados (_buildAccountCard) para padronização visual
// - Cores pré-definidas em constantes locais
//
// Os dados exibidos atualmente são estáticos,
// podendo ser integrados futuramente com APIs
// ou gerenciadores de estado para buscar as reais contas do usuário.
//
// ------------------------------------------------------------
//
// Boas práticas aplicadas:
//
// - Separação de responsabilidades na construção da interface
// - Uso de StatelessWidget, por não possuir estado mutável interno na UI atual
// - Componentização (_buildAccountCard)
// - Layout responsivo e organizado
//
// ------------------------------------------------------------
//
// Escalabilidade:
//
// Possíveis evoluções:
//
// - Integração com backend/API para listagem real de contas
// - Fluxo de navegação para a tela de "Adicionar Conta"
// - Navegação ao tocar no card de uma conta (detalhamento)
// - Internacionalização (i18n)
//
// ------------------------------------------------------------
//
// O que NÃO deve conter neste arquivo:
//
// - Lógica de negócio complexa
// - Regras de validação
// - Acesso direto a banco de dados
//
// Este arquivo é focado apenas na interface.
//
// ------------------------------------------------------------
//
// Autor(es):
// - Luiz Felipe Gregorio Gonçalves & Efraim Haniel Oliveira Moura
//
// Criado em: 05/04/2026
// Última modificação: 05/04/2026
//
// ------------------------------------------------------------
//
// Histórico de versões:
//
// Versão | Data       | Autor       | Descrição
// 1.0.0  | 05/04/2026 | Luiz Felipe & Efraim | Implementação inicial da MyAccountScreen
//
// ------------------------------------------------------------
//
// Licença:
// UNIBRAS License
// ============================================================

import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color cardColor = Color(0xFFF2F2F2);
    const Color cardBorderColor = Color(0xFF888888);
    const Color textColor = Color(0xFF4B4B4B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IF Bank', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Minhas Contas',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 24),
            _buildAccountCard(
              title: 'Conta Corrente',
              subtitle: 'Saldo',
              theme: theme,
              cardColor: cardColor,
              cardBorderColor: cardBorderColor,
              textColor: textColor,
              iconWidget: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: const Icon(Icons.credit_card, color: Colors.black, size: 36),
              ),
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              title: 'Conta Poupanca',
              subtitle: 'Saldo',
              theme: theme,
              cardColor: cardColor,
              cardBorderColor: cardBorderColor,
              textColor: textColor,
              iconWidget: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.credit_card, color: Colors.black, size: 28),
              ),
            ),
            const SizedBox(height: 16),
            _buildAccountCard(
              title: 'Outra Conta',
              subtitle: 'Saldo',
              theme: theme,
              cardColor: cardColor,
              cardBorderColor: cardBorderColor,
              textColor: textColor,
              iconWidget: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.credit_card, color: Colors.black, size: 28),
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                side: const BorderSide(color: cardBorderColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Adicionar Conta',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required String title,
    required String subtitle,
    required ThemeData theme,
    required Color cardColor,
    required Color cardBorderColor,
    required Color textColor,
    required Widget iconWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cardBorderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconWidget,
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 4),
              const Row(
                children: [
                  Text(
                    '•••• •••• •••',
                    style: TextStyle(color: Color(0xFF888888), fontSize: 16, letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF888888)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}