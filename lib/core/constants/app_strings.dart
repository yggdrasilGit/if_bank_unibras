/// ============================================================
/// Arquivo: app_strings.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este arquivo centraliza todos os textos (strings) utilizados
/// na aplicação IF Bank.
///
/// O objetivo é evitar hardcoded strings espalhadas pelo código,
/// facilitando:
/// - Manutenção
/// - Padronização
/// - Internacionalização (i18n)
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Centralizar textos da aplicação
/// - Evitar repetição de strings
/// - Facilitar tradução futura
/// - Melhorar legibilidade do código
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Core Layer
///
/// Atua como:
/// → Shared Constants
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AppStrings
///  ├── appName
///  ├── loginTitle
///  ├── email
///  ├── password
///  ├── signIn
///  ├── forgotPassword
///  ├── createAccount
///  └── noAccount
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Uso de constantes (const)
/// - Centralização de textos
/// - Evita strings mágicas no código
/// - Preparação para internacionalização (i18n)
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// Text(AppStrings.loginTitle)
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Para suportar múltiplos idiomas futuramente:
///
/// - Integrar com intl package
/// - Criar arquivos por idioma (pt, en, es)
///
/// Exemplo:
///
/// AppStringsPt
/// AppStringsEn
///
/// Ou usar:
///
/// Flutter Intl / arb files
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter neste arquivo:
///
/// - Lógica de negócio
/// - Strings dinâmicas complexas
/// - Textos formatados com lógica
///
/// Este arquivo deve conter apenas constantes simples.
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
/// 1.0.0  | 18/03/2026 | Francismar  | Centralização inicial de strings
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

/// Classe responsável por armazenar todas as strings da aplicação.
class AppStrings {
  /// Nome da aplicação
  static const appName = 'IF Bank';

  /// Título da tela de login
  static const loginTitle = 'Acesse sua conta';

  /// Label do campo de e-mail
  static const email = 'E-mail';

  /// Label do campo de senha
  static const password = 'Senha';

  /// Texto do botão de login
  static const signIn = 'Entrar';

  /// Texto do link "esqueci minha senha"
  static const forgotPassword = 'Esqueci minha senha';

  /// Texto do botão de criação de conta
  static const createAccount = 'Criar conta';

  /// Texto auxiliar para usuários sem conta
  static const noAccount = 'Ainda não tem conta?';
}