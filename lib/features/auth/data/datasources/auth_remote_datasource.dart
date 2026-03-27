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
///  ├── login()
///  ├── register()
///  └── requestPasswordReset()
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
/// - Simula também cadastro e recuperação de senha
///
/// ------------------------------------------------------------
///
/// Simulação atual:
///
/// Email: teste@ifbank.com
/// Senha: 123456
/// Fluxos extras:
/// - Cadastro com persistencia em memoria
/// - Recuperação de senha por e-mail cadastrado
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
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação mock do login remoto
/// 1.1.0  | 26/03/2026 | Caio Menin  | Inclusão de mock para cadastro e recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import '../../domain/entities/user_entity.dart';
import '../models/login_request_model.dart';

/// DataSource responsável por operações remotas de autenticação.
class AuthRemoteDataSource {
  final Map<String, ({String id, String name, String password})> _users = {
    'teste@ifbank.com': (id: '1', name: 'Usuário IF Bank', password: '123456'),
  };

  /// Realiza o login do usuário
  ///
  /// Retorna:
  /// - UserEntity em caso de sucesso
  ///
  /// Lança:
  /// - Exception em caso de falha
  Future<UserEntity> login(LoginRequestModel request) async {
    /// Simula delay de requisição HTTP
    await Future.delayed(const Duration(milliseconds: 900));

    final email = request.email.trim().toLowerCase();
    final user = _users[email];

    /// Validação mock de credenciais
    if (user != null && user.password == request.password) {
      return UserEntity(id: user.id, name: user.name, email: email);
    }

    /// Erro de autenticação
    throw Exception('Credenciais inválidas');
  }

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));

    final normalizedEmail = email.trim().toLowerCase();
    if (_users.containsKey(normalizedEmail)) {
      throw Exception('E-mail já cadastrado');
    }

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _users[normalizedEmail] = (id: id, name: name.trim(), password: password);

    return UserEntity(id: id, name: name.trim(), email: normalizedEmail);
  }

  Future<void> requestPasswordReset({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final normalizedEmail = email.trim().toLowerCase();
    if (!_users.containsKey(normalizedEmail)) {
      throw Exception('E-mail não encontrado');
    }
  }
}
