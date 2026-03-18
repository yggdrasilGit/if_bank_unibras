/// ============================================================
/// Arquivo: validator_service.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este serviço é responsável por centralizar validações de
/// formulários da aplicação, como e-mail e senha.
///
/// Ele é utilizado principalmente pelos ViewModels para validar
/// dados antes de executar regras de negócio.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Validar campos de entrada (forms)
/// - Reutilizar regras de validação
/// - Separar validação da UI
/// - Garantir consistência nas validações
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Core Layer
///
/// Atua como:
/// → Service (Shared Validation Logic)
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// ValidatorService
///  ├── validateEmail()
///  └── validatePassword()
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// Cada método retorna:
///
/// - null → quando o valor é válido
/// - String → mensagem de erro quando inválido
///
/// Esse padrão é compatível com:
/// → TextFormField.validator
///
/// ------------------------------------------------------------
///
/// Exemplo de uso:
///
/// TextFormField(
///   validator: validatorService.validateEmail,
/// )
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Reutilização de código
/// - Separação de responsabilidades
/// - Baixo acoplamento com a UI
/// - Código testável
///
/// ------------------------------------------------------------
///
/// Regras implementadas:
///
/// Email:
/// - Não pode ser vazio
/// - Deve ter formato válido
///
/// Senha:
/// - Não pode ser vazia
/// - Deve ter no mínimo 6 caracteres
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Novas validações podem ser adicionadas:
///
/// - CPF
/// - Telefone
/// - Senha forte
/// - Código OTP
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Regras de negócio complexas
/// - Chamadas de API
/// - Estado da aplicação
///
/// Este serviço é apenas para validação simples.
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
/// 1.0.0  | 18/03/2026 | Francismar  | Implementação inicial de validações
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

/// Serviço responsável por validações de formulário.
class ValidatorService {
  /// Valida o campo de e-mail
  ///
  /// Retorna:
  /// - null → válido
  /// - String → mensagem de erro
  String? validateEmail(String? value) {
    /// Verifica se está vazio
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu e-mail';
    }

    /// Regex para validação de e-mail
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    /// Verifica formato do e-mail
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Informe um e-mail válido';
    }

    /// Valor válido
    return null;
  }

  /// Valida o campo de senha
  ///
  /// Retorna:
  /// - null → válido
  /// - String → mensagem de erro
  String? validatePassword(String? value) {
    /// Verifica se está vazio
    if (value == null || value.isEmpty) {
      return 'Informe sua senha';
    }

    /// Verifica tamanho mínimo
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    /// Valor válido
    return null;
  }
}