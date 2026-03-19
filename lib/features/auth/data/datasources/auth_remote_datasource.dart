/// ============================================================
/// Arquivo: auth_remote_datasource.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este datasource é responsável por realizar operações remotas
/// relacionadas à autenticação.
///
/// Ele simula uma chamada de API de login e retorna um usuário
/// em caso de sucesso ou lança uma exceção em caso de falha.
///
/// Em um cenário real, este arquivo seria responsável por:
/// - Chamadas HTTP (REST API)
/// - Integração com backend
/// - Manipulação de respostas externas
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Realizar chamadas remotas de autenticação
/// - Converter dados de entrada em requisições
/// - Retornar dados no formato de entidade
/// - Lançar exceções em caso de erro
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Data Layer
///
/// Atua como:
/// → Remote DataSource
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - UserEntity
///   → Representação do usuário no domínio
///
/// - LoginRequestModel
///   → Dados da requisição de login
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AuthRemoteDataSource
///  └── login()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Recebe um LoginRequestModel
/// - Simula uma chamada remota (delay)
/// - Valida credenciais mockadas
/// - Retorna UserEntity em caso de sucesso
/// - Lança Exception em caso de erro
///
/// ------------------------------------------------------------
///
/// Simulação atual:
///
/// Email: teste@ifbank.com
/// Senha: 123456
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// final user = await dataSource.login(request);
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Separação de responsabilidade (Data Layer)
/// - Isolamento de acesso externo
/// - Preparado para integração real com API
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Em produção, substituir por:
///
/// - Dio / http package
/// - Tratamento de status code
/// - Serialização JSON
/// - Interceptors (token, headers)
///
/// Exemplo futuro:
///
/// final response = await dio.post('/login', data: request.toMap());
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Lógica de UI
/// - Regras de negócio
/// - Gerenciamento de estado
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
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação mock do login remoto
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import '../../domain/entities/user_entity.dart';
import '../models/login_request_model.dart';

/// DataSource responsável por operações remotas de autenticação.
class AuthRemoteDataSource {
  /// Realiza o login do usuário
  ///
  /// Retorna:
  /// - UserEntity em caso de sucesso
  ///
  /// Lança:
  /// - Exception em caso de falha
  Future<UserEntity> login(LoginRequestModel request) async {
    /// Simula delay de requisição HTTP
    await Future.delayed(const Duration(seconds: 2));

    /// Validação mock de credenciais
    if (request.email == 'teste@ifbank.com' &&
        request.password == '123456') {
      return const UserEntity(
        id: '1',
        name: 'Usuário IF Bank',
        email: 'teste@ifbank.com',
      );
    }

    /// Erro de autenticação
    throw Exception('Credenciais inválidas');
  }
}