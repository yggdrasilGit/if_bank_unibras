/// ============================================================
/// Arquivo: auth_injector.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Responsável pela configuração da injeção de dependências
/// da feature de autenticação.
///
/// Este módulo registra todos os componentes necessários
/// para o fluxo de login, conectando as camadas:
///
/// - Data
/// - Domain
/// - Presentation
///
/// Utiliza o Provider como mecanismo de Dependency Injection,
/// garantindo desacoplamento e escalabilidade.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Registrar dependências da feature Auth
/// - Garantir ordem correta de inicialização
/// - Disponibilizar instâncias para o restante da aplicação
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// → Dependency Injection (DI Layer)
///
/// Papel:
/// → Módulo de injeção por feature
///
/// ------------------------------------------------------------
///
/// Fluxo de dependências:
///
/// ViewModel
///   ↓
/// UseCase
///   ↓
/// Repository (interface)
///   ↓
/// RepositoryImpl
///   ↓
/// DataSource
///
/// ------------------------------------------------------------
///
/// Ordem de inicialização (IMPORTANTE):
///
/// 1. Services
/// 2. DataSources
/// 3. Repositories
/// 4. UseCases
/// 5. ViewModels
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Dependency Inversion Principle (DIP)
/// - Baixo acoplamento
/// - Alta coesão
/// - Modularização por feature
/// - Escalabilidade horizontal
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Novas dependências devem seguir o mesmo padrão:
///
/// Exemplo:
/// Provider<RegisterUseCase>
/// ChangeNotifierProvider<RegisterViewModel>
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Este arquivo NÃO deve conter:
///
/// - Lógica de negócio
/// - Widgets
/// - Chamadas diretas de API
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 18/03/2026
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação inicial do módulo de DI
/// 1.1.0  | 26/03/2026 | Caio Menin  | Registro dos fluxos de cadastro e recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:if_bank/features/auth/data/repositories/auth_repository.dart';
import 'package:if_bank/features/auth/domain/usercase/login_usercase.dart';
import 'package:if_bank/features/auth/domain/usercase/register_usercase.dart';
import 'package:if_bank/features/auth/domain/usercase/request_password_reset_usercase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/services/validator_service.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../presentation/viewmodels/forgot_password_viewmodel.dart';
import '../presentation/viewmodels/login_viewmodel.dart';
import '../presentation/viewmodels/register_viewmodel.dart';

/// Módulo de injeção de dependências da feature Auth.
class AuthInjector {
  /// Lista de providers utilizados no MultiProvider global
  static List<SingleChildWidget> get providers => [
    /// ============================
    /// Services
    /// ============================
    Provider<ValidatorService>(create: (_) => ValidatorService()),

    /// ============================
    /// DataSources
    /// ============================
    Provider<AuthRemoteDataSource>(create: (_) => AuthRemoteDataSource()),

    /// ============================
    /// Repositories
    /// ============================
    Provider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(
        remoteDataSource: context.read<AuthRemoteDataSource>(),
      ),
    ),

    /// ============================
    /// UseCases
    /// ============================
    Provider<LoginUseCase>(
      create: (context) =>
          LoginUseCase(repository: context.read<AuthRepository>()),
    ),
    Provider<RegisterUseCase>(
      create: (context) =>
          RegisterUseCase(repository: context.read<AuthRepository>()),
    ),
    Provider<RequestPasswordResetUseCase>(
      create: (context) => RequestPasswordResetUseCase(
        repository: context.read<AuthRepository>(),
      ),
    ),

    /// ============================
    /// ViewModels
    /// ============================
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        loginUseCase: context.read<LoginUseCase>(),
        validatorService: context.read<ValidatorService>(),
      ),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(
        registerUseCase: context.read<RegisterUseCase>(),
        validatorService: context.read<ValidatorService>(),
      ),
    ),
    ChangeNotifierProvider<ForgotPasswordViewModel>(
      create: (context) => ForgotPasswordViewModel(
        requestPasswordResetUseCase: context
            .read<RequestPasswordResetUseCase>(),
        validatorService: context.read<ValidatorService>(),
      ),
    ),
  ];
}
