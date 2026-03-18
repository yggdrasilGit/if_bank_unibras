/// ============================================================
/// Arquivo: user_entity.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Esta classe representa a entidade de usuário no domínio
/// da aplicação.
///
/// Entidades são objetos centrais na Clean Architecture e
/// representam regras e estruturas puras do negócio,
/// independentes de frameworks ou implementações externas.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Representar um usuário no domínio
/// - Definir estrutura de dados do negócio
/// - Servir como contrato entre camadas
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Domain Layer
///
/// Atua como:
/// → Entity (Business Object)
///
/// ------------------------------------------------------------
///
/// Características de uma Entity:
///
/// - Imutável (dados não mudam após criação)
/// - Independente de frameworks (Flutter, API, etc)
/// - Contém apenas dados relevantes ao negócio
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// UserEntity
///  ├── id
///  ├── name
///  └── email
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// A entidade representa um usuário autenticado no sistema.
/// Ela é utilizada por:
///
/// - UseCases
/// - ViewModels
/// - Repositories
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// final user = UserEntity(
///   id: '1',
///   name: 'João',
///   email: 'joao@email.com',
/// );
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Imutabilidade (uso de const + final)
/// - Simplicidade
/// - Independência de camada externa
/// - Clareza de responsabilidade
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido com novos atributos:
///
/// - phone
/// - token
/// - createdAt
///
/// Ou comportamentos de domínio:
///
/// bool get isEmailValid => email.contains('@');
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Lógica de UI
/// - Chamadas de API
/// - Dependência de Flutter
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
/// 1.0.0  | 17/03/2026 | Seu Nome    | Criação da entidade User
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

/// Entidade que representa um usuário no domínio da aplicação.
class UserEntity {
  /// Identificador único do usuário
  final String id;

  /// Nome do usuário
  final String name;

  /// E-mail do usuário
  final String email;

  /// Construtor da entidade (imutável)
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}