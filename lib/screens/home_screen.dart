import 'package:flutter/material.dart';

class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color cardColor = Color(0xFFE2E2E2);
    const Color cardBorderColor = Color(0xFF888888);
    const Color textColor = Color(0xFF4B4B4B);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('IF Bank', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Bem-vindo de volta,\n[Nome do Usuario]',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                    color: const Color(0xFFE2E2E2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.person_outline, size: 32, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cardBorderColor),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patrimonio Total',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$1.034,07',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'artoracao\ngrafce placsiicidar',
                    style: theme.textTheme.bodySmall?.copyWith(color: textColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                        ),
                        child: Text('Ações', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Crypto', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('FIIs', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cardBorderColor),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minhas Contas',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
                  ),
                  const SizedBox(height: 16),
                  _buildContaRow('Conta Corrente', 'R\$1.000,00', theme, textColor),
                  const SizedBox(height: 16),
                  _buildContaRow('Conta Poupanca', 'R\$3 000,00', theme, textColor),
                ],
              ),
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                side: const BorderSide(color: cardBorderColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Ver Meus investimentos',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                side: const BorderSide(color: cardBorderColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Ver Minhas Contas',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContaRow(String title, String value, ThemeData theme, Color textColor) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE2E2E2),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF888888)),
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.credit_card, color: Colors.black),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
            Text(value, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ],
    );
  }
}