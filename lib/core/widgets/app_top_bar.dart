/// ============================================================
/// Arquivo: app_top_bar.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// Widget reutilizavel de AppBar para padronizar cabecalho
/// nas telas da aplicacao.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Exibir titulo da tela
/// - Exibir botao de voltar opcional
/// - Aplicar estilo consistente de AppBar
/// - Permitir fallback de rota quando nao houver pop
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// -> Core / Shared UI Components
///
/// Tipo:
/// -> Reusable Widget (Presentation Support)
///
/// ------------------------------------------------------------
///
/// Dependencias externas:
///
/// - flutter/material.dart
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AppTopBar
///  -> AppBar
///       -> Leading (opcional)
///       -> Title
///       -> Actions (opcional)
///
/// ------------------------------------------------------------
///
/// Fluxo:
///
/// - Se showBackButton for true:
///   - tenta Navigator.pop()
///   - se nao houver tela anterior e fallbackRoute existir:
///     - usa Navigator.pushReplacementNamed()
///
/// ------------------------------------------------------------
///
/// Boas praticas:
///
/// - Reutilizacao de UI
/// - Consistencia visual
/// - Baixo acoplamento entre telas
///
/// ------------------------------------------------------------
///
/// Restricoes:
///
/// Nao deve conter:
///
/// - Regra de negocio
/// - Chamada de API
/// - Estado de dominio
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 26/03/2026
/// Ultima modificacao: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Historico:
///
/// Versao | Data       | Autor       | Descricao
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criacao do AppBar reutilizavel
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final String? fallbackRoute;
  final List<Widget>? actions;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.fallbackRoute,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: showBackButton ? 56 : 0,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                  return;
                }
                if (fallbackRoute != null) {
                  Navigator.pushReplacementNamed(context, fallbackRoute!);
                }
              },
              icon: const Icon(Icons.arrow_back, size: 20),
              tooltip: 'Voltar',
            )
          : null,
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: actions,
    );
  }
}
