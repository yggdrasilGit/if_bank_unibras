/// ============================================================
/// Arquivo: login_request_model.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este model representa os dados necessários para realizar
/// uma requisição de login.
///
/// Ele pertence à camada de dados (Data Layer) e é responsável
/// por estruturar os dados que serão enviados para APIs ou
/// fontes externas.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Representar dados de entrada para login
/// - Converter dados para formato serializável (Map)
/// - Servir como ponte entre ViewModel e DataSource
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Data Layer
///
/// Atua como:
/// → Data Model (DTO - Data Transfer Object)
///
/// ------------------------------------------------------------
///
/// Diferença entre Entity e Model:
///
/// Entity:
/// - Representa o domínio (negócio)
/// - Independente de API
///
/// Model:
/// - Representa estrutura de dados externa
/// - Pode ser serializado (JSON/Map)
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginRequestModel
///  ├── email
///  ├── password
///  └── toMap()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// O model é usado para:
///
/// - Enviar dados para API
/// - Converter dados para JSON/Map
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// final request = LoginRequestModel(
///   email: 'teste@ifbank.com',
///   password: '123456',
/// );
///
/// api.post('/login', body: request.toMap());
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Imutabilidade (const + final)
/// - Separação de responsabilidades
/// - Preparação para integração com API
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido com:
///
/// - toJson()
/// - fromJson()
/// - validações específicas
///
/// Exemplo:
///
/// factory LoginRequestModel.fromJson(Map<String, dynamic> json)
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Regras de negócio
/// - Lógica de UI
/// - Dependência de Flutter
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Seu Nome
///
/// Criado em: 18/3/2026
/// Última modificação: 18/3/2026
///
/// ------------------------------------------------------------
///
/// Histórico de versões:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Criação do model de login
/// 
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

/// Model que representa os dados de requisição de login.
class LoginRequestModel {
  /// E-mail do usuário
  final String email;

  /// Senha do usuário
  final String password;

  /// Construtor imutável
  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  /// Converte o objeto para Map (utilizado em requisições HTTP)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}