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
library;

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
      return 'Informe um e-mail valido';
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
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }

    /// Evita senha somente numérica
    if (RegExp(r'^\d+$').hasMatch(value)) {
      return 'A senha nao pode ser inteiramente numerica';
    }

    const commonPasswords = {
      '123456',
      '12345678',
      '123456789',
      '1234567890',
      'password',
      'senha',
      'qwerty',
      'admin',
    };
    if (commonPasswords.contains(value.toLowerCase())) {
      return 'Escolha uma senha menos comum';
    }

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasNumber) {
      return 'Use letras e numeros na senha';
    }

    return null;
  }

  /// Valida CPF (somente digitos, 11 posicoes)
  String? validateCpf(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu CPF';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) {
      return 'Informe um CPF valido';
    }

    return null;
  }

  /// Valida telefone (minimo de 10 digitos)
  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu telefone';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      return 'Informe um telefone valido';
    }

    return null;
  }

  /// Valida data no formato DD/MM/YYYY
  String? validateBirthDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe sua data de nascimento';
    }

    final input = value.trim();
    final match = RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$').firstMatch(input);
    if (match == null) {
      return 'Use o formato DD/MM/YYYY';
    }

    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);

    final parsed = DateTime.tryParse('$year-$month-$day');
    if (parsed == null ||
        parsed.year != year ||
        parsed.month != month ||
        parsed.day != day) {
      return 'Informe uma data valida';
    }

    return null;
  }
}
