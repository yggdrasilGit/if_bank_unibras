/// ============================================================
/// Arquivo: login_usecase.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este UseCase representa a ação de login do usuário no sistema.
///
/// Ele pertence à camada de domínio e é responsável por
/// orquestrar a execução da regra de negócio relacionada
/// à autenticação.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Executar a ação de login
/// - Orquestrar chamadas ao repositório
/// - Servir como ponto de entrada da regra de negócio
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Domain Layer
///
/// Atua como:
/// → UseCase (Application Business Rule)
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - AuthRepository
///   → Interface do domínio
///
/// - UserEntity
///   → Entidade de usuário
///
/// - Result
///   → Wrapper de retorno
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginUseCase
///  ├── repository
///  └── call()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Recebe dados (email, password)
/// - Chama o repositório
/// - Retorna resultado (`Result<UserEntity>`)
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
/// final result = await loginUseCase(
///   email: 'teste@ifbank.com',
///   password: '123456',
/// );
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separação de responsabilidades
/// - Independência de framework
/// - Testabilidade
/// - Uso de contrato (interface)
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Aqui é onde entram regras reais, por exemplo:
///
/// - Validação de credenciais antes da chamada
/// - Tratamento de múltiplos cenários
/// - Logs de auditoria
/// - Integração com biometria
///
/// Exemplo futuro:
///
/// if (!email.contains('@')) return Result.failure('Email inválido');
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Widgets
/// - Código de UI
/// - Dependência de Flutter
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
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação inicial do UseCase de login
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/data/repositories/auth_repository.dart';


import '../entities/user_entity.dart';


/// UseCase responsável pela ação de login do usuário.
class LoginUseCase {
  /// Repositório de autenticação (contrato)
  final AuthRepository repository;

  /// Construtor com injeção de dependência
  LoginUseCase({
    required this.repository,
  });

  /// Executa o login
  ///
  /// Retorna:
  /// - Result.success(UserEntity)
  /// - Result.failure(String)
  Future<Result<UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
