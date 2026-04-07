/// ============================================================
/// Arquivo: auth_repository_impl.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Esta classe é a implementação concreta do AuthRepository,
/// responsável por conectar a camada de domínio com a camada
/// de dados.
///
/// Ela atua como intermediária entre:
/// - DataSource (dados externos)
/// - Domain (regras de negócio)
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Implementar contratos do domínio (AuthRepository)
/// - Orquestrar chamadas ao DataSource
/// - Tratar erros e exceções
/// - Retornar resultados padronizados (Result)
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Data Layer
///
/// Atua como:
/// → Repository Implementation
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - result.dart
///   → Wrapper de sucesso/erro
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - AuthRepository (interface do domínio)
/// - AuthRemoteDataSource (fonte de dados)
/// - LoginRequestModel (model de requisição)
/// - UserEntity (entidade do domínio)
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AuthRepositoryImpl
///  ├── remoteDataSource
///  ├── login()
///  ├── register()
///  └── requestPasswordReset()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Recebe dados primitivos (email, password)
/// - Converte para LoginRequestModel
/// - Chama o DataSource
/// - Retorna Result.success em caso de sucesso
/// - Retorna Result.failure em caso de erro
/// - Implementa tambem cadastro e recuperacao de senha
///
/// ------------------------------------------------------------
///
/// Fluxo:
///
/// ViewModel
///   → UseCase
///     → Repository (interface)
///       → RepositoryImpl
///         → DataSource
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// final result = await repository.login(
///   email: 'teste@ifbank.com',
///   password: '123456',
/// );
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Dependency Injection
/// - Separation of Concerns
/// - Tratamento centralizado de erro
/// - Conversão de exceções em Result
///
/// ------------------------------------------------------------
///
/// Tratamento de erro:
///
/// - Captura exceções do DataSource
/// - Converte para mensagem amigável
/// - Remove prefixo "Exception: "
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode evoluir para:
///
/// - Múltiplos DataSources (local + remoto)
/// - Cache local
/// - Retry automático
/// - Logs e analytics
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Lógica de UI
/// - Widgets
/// - Estado da aplicação
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 17/03/2026
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 17/03/2026 | Francismar  | Implementação do repositório de autenticação
/// 1.1.0  | 26/03/2026 | Caio Menin  | Inclusão dos fluxos de cadastro e recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/data/repositories/auth_repository.dart';

import '../../domain/entities/user_entity.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

/// Implementação concreta do repositório de autenticação.
class AuthRepositoryImpl implements AuthRepository {
  /// Fonte de dados remota
  final AuthRemoteDataSource remoteDataSource;

  /// Construtor com injeção de dependência
  AuthRepositoryImpl({required this.remoteDataSource});

  /// Realiza o login do usuário
  ///
  /// Retorna:
  /// - Result.success(UserEntity) em caso de sucesso
  /// - Result.failure(String) em caso de erro
  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      /// Chamada ao datasource com conversão para model
      final user = await remoteDataSource.login(
        LoginRequestModel(email: email, password: password),
      );

      /// Retorno de sucesso
      return Result.success(user);
    } catch (e) {
      /// Tratamento de erro e padronização da mensagem
      return Result.failure(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Result<UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required String birthDate,
  }) async {
    try {
      final user = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        cpf: cpf,
        phone: phone,
        birthDate: birthDate,
      );

      return Result.success(user);
    } catch (e) {
      return Result.failure(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Result<String>> requestPasswordReset({required String email}) async {
    try {
      await remoteDataSource.requestPasswordReset(email: email);
      return Result.success('Instruções enviadas com sucesso');
    } catch (e) {
      return Result.failure(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
