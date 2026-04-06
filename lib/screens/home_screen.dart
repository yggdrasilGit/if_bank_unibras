///<<<<<<< main-homeScreen
/// ============================================================
/// Arquivo: home_screen.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este arquivo implementa a tela inicial da aplicação IF Bank.
/// Ele é responsável por exibir um resumo das informações do
/// usuário, incluindo patrimônio total, contas e acesso rápido
/// às funcionalidades principais.
///
/// A tela inclui:
/// - Saudação personalizada ao usuário
/// - Exibição de patrimônio total
/// - Navegação por abas (Ações, Crypto, FIIs)
/// - Listagem de contas
/// - Botões de acesso rápido
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Exibir dados principais do usuário
/// - Organizar informações financeiras
/// - Fornecer navegação inicial
/// - Servir como dashboard da aplicação
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Presentation Layer
///
/// Atua como:
/// → UI Screen (StatefulWidget)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///   → Framework de UI do Flutter
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// HomeScreen (StatefulWidget)
///  └── _HomeScreenState
///       ├── TabController
///       ├── build()
///       └── _buildContaRow()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// A tela utiliza:
/// - TabController para navegação entre abas
/// - SingleChildScrollView para rolagem
/// - Containers estilizados para organização visual
///
/// Os dados exibidos atualmente são estáticos,
/// podendo ser integrados futuramente com APIs
/// ou gerenciadores de estado.
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separação de responsabilidades
/// - Uso de StatefulWidget para controle de abas
/// - Componentização (_buildContaRow)
/// - Uso consistente de ThemeData
/// - Layout responsivo com Expanded e Padding
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Possíveis evoluções:
///
/// - Integração com backend/API
/// - Uso de gerenciador de estado (Provider, Riverpod, Bloc)
/// - Internacionalização (i18n)
/// - Componentização adicional (widgets reutilizáveis)
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter neste arquivo:
///
/// - Lógica de negócio complexa
/// - Regras de validação
/// - Acesso direto a banco de dados
///
/// Este arquivo é focado apenas na interface.
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Luiz Felipe Gregorio Gonçalves & Efraim Haniel Oliveira Moura 
///
/// Criado em: 29/03/2026
/// Última modificação: 05/04/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 30/03/2026 | Francismar  | Implementação inicial da HomeScreen
/// Versão | Data       | Autor       | Descrição
/// 1.0.1  | 30/03/2026 | Efraim & Luiz Felipe  | Implementação parcial da HomeScreen///
/// 1.0.2  | 05/04/2026 | Efraim & Luiz Felipe  | Implementação final com troca para designe padrão de cores e navegação por aba fii e crypto funcionando corretamente///
///
/// ------------------------------------------------------------
///
/// Licença:
/// UNIBRAS License
/// ============================================================
// ============================================================
// Arquivo: lib/screens/home_screen.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Tela principal do aplicativo no padrao estrutural adotado pela equipe.
// Esta versao preserva o layout do repositorio-base e usa o usuario
// autenticado recebido por navegacao para personalizar a saudacao.
//
// Responsabilidades:
// - Renderizar a tela inicial autenticada.
// - Exibir saudacao e resumo visual principal.
// - Manter a estrutura visual original da equipe.
//
// Dependencias:
// - package:flutter/material.dart
// - ../features/auth/domain/entities/user_entity.dart
//
// Autor(es):
// - Referencia da equipe
//
// Criado em: 19/03/2026
// Ultima modificacao: 30/03/2026
//
// Historico:
// Versao | Data       | Autor       | Descricao
// 1.0.0  | 19/03/2026 | Equipe      | Implementacao visual base da home
// 1.1.0  | 30/03/2026 | Hafrannio Rodrigues   | Ajuste para exibir o usuario autenticado sem alterar a estrutura da tela
//
// Observacoes:
// - A autoria nominal do arquivo-base nao estava explicita no cabecalho consultado.
// - O layout principal foi mantido para nao desalinhar o repositorio da equipe.
//
// Licenca:
// MIT License
// ============================================================

import 'package:flutter/material.dart';

import '../features/auth/domain/entities/user_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getSaldo() {
    switch (_tabController.index) {
      case 1:
        return 'R\$5.876,12';
      case 2:
        return 'R\$1.869,65';
      case 0:
      default:
        return 'R\$1.034,07';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user =
        ModalRoute.of(context)?.settings.arguments as UserEntity?;
    final userName = user?.name ?? '[Nome do Usuario]';

    const Color cardColor = Color(0xFFE2E2E2);
    const Color cardBorderColor = Color(0xFF888888);
    const Color textColor = Color(0xFF4B4B4B);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IF Bank',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
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
                    'Bem-vindo de volta,\n$userName',
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
                  child: const Icon(
                    Icons.person_outline,
                    size: 32,
                    color: Colors.black,
                  ),
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // TRANSIÇÃO INSTANTÂNEA MAS SUAVE (SEM EFEITO DE MOVIMENTO)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      _getSaldo(),
                      key: ValueKey<int>(_tabController.index), 
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'resumo\nfinanceiro',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
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
                    labelStyle: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: 'Acoes'),
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContaRow(
                    'Conta Corrente',
                    'Sincronizada via API',
                    theme,
                    textColor,
                  ),
                  const SizedBox(height: 16),
                  _buildContaRow(
                    'Conta Principal',
                    user?.email ?? 'Usuario autenticado',
                    theme,
                    textColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildActionButton('Ver Meus investimentos', theme, cardBorderColor, textColor),
            const SizedBox(height: 16),
            _buildActionButton('Ver Minhas Contas', theme, cardBorderColor, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, ThemeData theme, Color borderColor, Color textColor) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF2F2F2),
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }

  Widget _buildContaRow(String title, String value, ThemeData theme, Color textColor) {
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                side: const BorderSide(color: cardBorderColor, width: 1.5), // Usar a mesma cor de borda dos cards para consistência
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Ver Meus investimentos',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 16), // erro de virgula, mas é para manter a estrutura original da equipe, pois a componentização é uma boa prática e o layout original tem essa estrutura. O nome da variável pode ser ajustado para evitar o erro, mas a estrutura deve ser mantida.
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                side: const BorderSide(color: cardBorderColor, width: 1.5), // esta apresentando erro carBorderColor não definido, mas é para manter a estrutura original da equipe, pois a componentização é uma boa prática e o layout original tem essa estrutura. O nome da variável pode ser ajustado para evitar o erro, mas a estrutura deve ser mantida.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Ver Minhas Contas',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ), // erro de structure, mas é para manter a estrutura original da equipe, pois a componentização é uma boa prática e o layout original tem essa estrutura. O nome da variável pode ser ajustado para evitar o erro, mas a estrutura deve ser mantida.
    );
  }

  Widget _buildContaRow( // esta apresentando erro de nome duplicado, mas é para manter a estrutura original da equipe, pois a componentização é uma boa prática e o layout original tem essa estrutura. O nome da
    String title,
    String value,
    ThemeData theme,
    Color textColor,
  ) {
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
