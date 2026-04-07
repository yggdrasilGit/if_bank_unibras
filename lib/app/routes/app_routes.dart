/// ============================================================
/// Arquivo: app_routes.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este arquivo centraliza a configuração de rotas da aplicação.
/// Ele define os caminhos de navegação (routes) e mapeia cada
/// rota para sua respectiva tela.
///
/// O objetivo é manter a navegação organizada, desacoplada
/// das views e fácil de escalar.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Definir constantes de rotas
/// - Mapear rotas para Widgets (telas)
/// - Centralizar navegação da aplicação
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → App Layer
///
/// Atua como:
/// → Navigation Layer
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///   → Necessário para WidgetBuilder
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - login_page.dart
///   → Tela inicial de autenticação
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AppRoutes
///  ├── login (const)
///  └── routes (map)
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// Cada rota é representada por:
/// - Uma String (caminho)
/// - Um WidgetBuilder (função que retorna a tela)
///
/// Exemplo:
///
/// '/' → LoginPage
///
///
/// ------------------------------------------------------------
///
/// Fluxo de navegação:
///
/// app.dart
///   → MaterialApp
///     → initialRoute
///       → AppRoutes.login
///         → LoginPage
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Centralização de rotas
/// - Uso de constantes (evita erros de string)
/// - Baixo acoplamento entre telas
/// - Escalabilidade de navegação
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Para adicionar novas telas:
///
/// 1) Criar constante:
/// static const String home = '/home';
///
/// 2) Registrar no map:
/// home: (_) => const HomePage(),
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter neste arquivo:
///
/// - Lógica de negócio
/// - Regras de autenticação
/// - Estado da aplicação
///
/// Este arquivo é apenas para navegação.
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
/// 1.0.0  | 18/03/2026 | Francismar  | Estrutura inicial de rotas
/// 1.0.1  | 18/03/2026 | Francismar  | Incluido a Rota de Registro
///
/// ------------------------------------------------------------
///
/// Licença:
/// UNIBRAS License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:if_bank/screens/accounts_screen.dart';
import 'package:if_bank/screens/edit_profile_screen.dart';
import 'package:if_bank/screens/forgot_password_screen.dart';
import 'package:if_bank/screens/home_screen.dart';
import 'package:if_bank/screens/investments_screen.dart';
import 'package:if_bank/screens/login_screen.dart';
import 'package:if_bank/screens/register_screen.dart';

import '../../features/auth/presentation/views/login_page.dart';

/// Classe responsável por centralizar as rotas da aplicação.
class AppRoutes {
  /// Rota inicial (Login)
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String editProfile = '/edit-profile';
  static const String accounts = '/accounts';
  static const String investments = '/investments';

  /// Rota da página de (Registro)
  // static const Register register = '/register'

  /// Rota da Página inical do App
  static const String loginScreen = "/";

  /// Mapa de rotas da aplicação
  static Map<String, WidgetBuilder> get routes => {
    /// Mapeamento da rota de login
    login: (_) => const LoginPage(),
    // register: (_) => const RegisterPage(),

    /// Mapeamento da rota de login
    loginScreen: (_) => LoginScreen(),
    register: (_) => const RegisterScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    home: (_) => const HomeScreen(),
    editProfile: (_) => const EditProfileScreen(),
    accounts: (_) => const AccountsScreen(),
    investments: (_) => const InvestmentsScreen(),
  };
}
