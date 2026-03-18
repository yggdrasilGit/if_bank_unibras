/// ============================================================
/// Arquivo: login_header.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este widget representa o cabeçalho da tela de login.
///
/// Ele exibe elementos visuais institucionais como:
/// - Ícone da aplicação
/// - Nome do app
/// - Texto de apoio (subtítulo)
///
/// Este componente é reutilizável e segue o princípio de
/// componentização da UI.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Exibir identidade visual do app
/// - Apresentar título e subtítulo da tela de login
/// - Manter consistência visual entre telas
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Presentation Layer
///
/// Atua como:
/// → UI Component (Widget)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///   → Widgets básicos de UI
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - AppStrings
///   → Centralização de textos da aplicação
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginHeader
///  └── Column
///       ├── SvgPicture.asset(logo)
///       ├── Text (nome do app)
///       └── Text (subtítulo)
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Renderiza um layout vertical (Column)
/// - Exibe ícone representando o banco
/// - Mostra nome da aplicação
/// - Exibe mensagem de acesso à conta
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - StatelessWidget (sem estado)
/// - Uso de constantes (const)
/// - Separação de UI em componentes
/// - Reutilização de strings centralizadas
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido com:
///
/// - Logo via Image.asset()
/// - Suporte a temas dinâmicos
/// - Internacionalização (i18n)
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Lógica de negócio
/// - Estado (setState / ChangeNotifier)
/// - Chamadas de API
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Seu Nome
///
/// Criado em: 17/03/2026
/// Última modificação: 17/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 17/03/2026 | Seu Nome    | Criação do header da tela de login
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_strings.dart';

/// Widget responsável pelo cabeçalho da tela de login.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Ícone principal da aplicação
        SvgPicture.asset("assets/images/logo_if_bank.svg"),

        /// Espaçamento
        const SizedBox(height: 16),

        /// Nome da aplicação
        const Text(
          AppStrings.appName,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        /// Espaçamento
        const SizedBox(height: 8),

        /// Subtítulo da tela
        const Text(AppStrings.loginTitle, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
