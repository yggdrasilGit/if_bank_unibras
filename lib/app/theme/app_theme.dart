import 'package:flutter/material.dart';

/// ============================================================
/// Arquivo: app_theme.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este arquivo define o tema global da aplicação IF Bank.
/// Ele centraliza toda a configuração visual, garantindo
/// consistência de design em toda a aplicação.
///
/// O tema inclui:
/// - Cores principais
/// - Estilo de inputs
/// - Botões
/// - Cards
/// - Configuração do Material Design 3
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Definir identidade visual da aplicação
/// - Padronizar estilos de componentes
/// - Facilitar manutenção de UI
/// - Garantir consistência visual
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → App Layer
///
/// Atua como:
/// → Design System (UI Configuration)
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
/// AppTheme
///  └── lightTheme (ThemeData)
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// O ThemeData define:
/// - Esquema de cores (ColorScheme)
/// - Background da aplicação
/// - Estilo de inputs
/// - Estilo de botões
/// - Estilo de cards
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Centralização do tema
/// - Reutilização de estilos
/// - Consistência visual
/// - Uso de Material 3
/// - Customização via ColorScheme
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Para suportar múltiplos temas:
///
/// static ThemeData get darkTheme => ...
///
/// Ou temas por ambiente/marca.
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter neste arquivo:
///
/// - Lógica de negócio
/// - Estado da aplicação
/// - Regras de validação
///
/// Este arquivo é exclusivamente visual.
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 18/03/2026
/// Última modificação: 18/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Tema inicial do app
///
/// ------------------------------------------------------------
///
/// Licença:
/// UNIBRAS License
/// ============================================================

class AppTheme {
  /// Tema claro da aplicação
  static ThemeData get lightTheme {
    /// Cor primária da marca IF Bank
    const Color primaryColor = Color(0xFF10B981);
    const Color secundaryColor = Color(0xff475569);
    const Color  terciaryColor = Color(0xffffffff);
    const Color fistColor = Color(0xFF0F172A);

    /// Cor padrão dos textos (branco)
    const textColor = terciaryColor;

    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        brightness: Brightness.dark, // 👈 importante
      ),

      /// Fundo escuro
      scaffoldBackgroundColor: fistColor,

      /// 🔥 TEXTOS GLOBAIS
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        titleSmall: TextStyle(color: textColor),
      ),

      /// ÍCONES BRANCOS
      iconTheme: const IconThemeData(color: terciaryColor),

      /// INPUTS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secundaryColor,

        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white54),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: secundaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),

      ///  BOTÕES
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: terciaryColor,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      /// CARDS
      cardTheme: CardThemeData(
        elevation: 4,
        color: secundaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
