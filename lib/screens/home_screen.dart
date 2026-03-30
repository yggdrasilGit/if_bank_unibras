import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color cardColor = Color(0xFFE2E2E2);
    const Color cardBorderColor = Color(0xFF888888);
    const Color textColor = Color(0xFF4B4B4B);

    return Scaffold(
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
                  child: const Icon(Icons.person_outline, size: 32),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.only(right: 32),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black,
                    unselectedLabelColor: textColor.withAlpha(153),
                    labelStyle: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'Ações'),
                      Tab(text: 'Crypto'),
                      Tab(text: 'FIIs'),
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
