/// ============================================================
/// Arquivo: result.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Esta classe representa um padrão de retorno para operações
/// que podem resultar em sucesso ou falha.
///
/// Ela é utilizada principalmente em:
/// - UseCases
/// - Repositories
/// - Camada de dados
///
/// O objetivo é evitar uso de exceptions como fluxo principal
/// e padronizar respostas da aplicação.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Representar sucesso com dados
/// - Representar falha com mensagem de erro
/// - Padronizar retornos entre camadas
/// - Evitar try/catch espalhado no código
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Core Layer
///
/// Atua como:
/// → Wrapper de resultado (Result Pattern)
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// `Result<T>`
///  ├── data (T?)
///  ├── error (String?)
///  ├── isSuccess (bool)
///  ├── isFailure (bool)
///  ├── success() (factory)
///  └── failure() (factory)
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Em caso de sucesso:
///   → data contém valor
///   → error é null
///
/// - Em caso de falha:
///   → error contém mensagem
///   → data é null
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// final result = await loginUseCase(...);
///
/// if (result.isSuccess) {
///   print(result.data);
/// } else {
///   print(result.error);
/// }
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Evita uso excessivo de exceptions
/// - Tipagem genérica (T)
/// - Código mais previsível
/// - Facilita testes unitários
///
/// ------------------------------------------------------------
///
/// Vantagens:
///
/// - Fluxo mais controlado
/// - Melhor legibilidade
/// - Padronização entre camadas
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido para incluir:
///
/// - códigos de erro
/// - tipos de erro (enum)
/// - stacktrace
///
/// Exemplo:
///
/// final int? code;
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Lógica de negócio
/// - Regras de validação
///
/// Essa classe é apenas estrutural.
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 17/03/2026
/// Última modificação: 17/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 17/03/2026 | Francismar  | Implementação inicial do Result Pattern
///
/// ------------------------------------------------------------
///
/// Licença:
/// UNIBRAS License
/// ============================================================
library;

/// Classe genérica que representa o resultado de uma operação.
class Result<T> {
  /// Dados retornados em caso de sucesso
  final T? data;

  /// Mensagem de erro em caso de falha
  final String? error;

  /// Construtor privado
  const Result._({
    this.data,
    this.error,
  });

  /// Retorna true se a operação foi bem-sucedida
  bool get isSuccess => error == null;

  /// Retorna true se houve falha na operação
  bool get isFailure => error != null;

  /// Factory para criar um resultado de sucesso
  factory Result.success(T data) => Result._(data: data);

  /// Factory para criar um resultado de falha
  factory Result.failure(String error) => Result._(error: error);
}
