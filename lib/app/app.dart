/// ============================================================
/// Arquivo: app.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este arquivo define o widget raiz da aplicação IF Bank.
/// Ele é responsável por configurar dependências globais,
/// gerenciamento de estado, tema da aplicação e sistema
/// de rotas.
///
/// Atua como ponto central da inicialização da UI,
/// conectando todas as camadas da aplicação.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Inicializar gerenciamento de estado (Provider)
/// - Registrar dependências via Dependency Injection
/// - Configurar tema global da aplicação
/// - Configurar navegação (rotas)
/// - Definir configurações base do MaterialApp
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → App Layer
///
/// Estrutura:
///
/// if_bank_bras
///  └── lib
///       └── app
///            ├── app.dart
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///   → Framework base Flutter
///
/// - provider
///   → Gerenciamento de estado e injeção de dependência
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - auth_injector.dart
///   → Registra dependências da feature de autenticação
///
/// - app_routes.dart
///   → Centraliza navegação da aplicação
///
/// - app_theme.dart
///   → Define identidade visual global
///
/// ------------------------------------------------------------
///
/// Fluxo de execução:
///
/// main.dart
///   → runApp()
///     → IfBankApp
///       → MultiProvider
///         → MaterialApp
///           → Routes
///             → LoginPage
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separation of Concerns
/// - Dependency Injection
/// - Centralized Configuration
/// - Modular Architecture
/// - Low Coupling
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter neste arquivo:
///
/// - Regras de negócio
/// - Chamadas de API
/// - Lógica de autenticação
/// - Validações
///
/// Essas responsabilidades pertencem às camadas:
///
/// - domain
/// - data
/// - presentation/viewmodels
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Novas features devem registrar seus providers aqui
/// através de seus respectivos injectors.
///
/// Exemplo:
///
/// providers: [
///   ...AuthInjector.providers,
///   ...HomeInjector.providers,
/// ]
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves martins Junior
///
/// Criado em: 18/03/2026
/// Última modificação: 18/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Estrutura inicial do App
///
/// ------------------------------------------------------------
///
/// Licença:
/// Unibras License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/di/auth_injector.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

/// Widget raiz da aplicação IF Bank.
///
/// Responsável por inicializar providers globais,
/// tema da aplicação e navegação.
class IfBankApp extends StatelessWidget {
  const IfBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// Lista de providers registrados via injector.
      providers: AuthInjector.providers,

      /// MaterialApp recebe toda a configuração global do app.
      child: MaterialApp(
        /// Nome da aplicação
        title: 'IF Bank',

        /// Remove banner de debug
        debugShowCheckedModeBanner: false,

        /// Tema global da aplicação
        theme: AppTheme.lightTheme,

        /// Rota inicial ao abrir o app
        initialRoute: AppRoutes.login,

        /// Mapa de rotas da aplicação
        routes: AppRoutes.routes,
      ),
    );
  }
}