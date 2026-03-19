/// ============================================================
/// Arquivo: login_password_field.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Este widget representa o campo de senha da tela de login.
///
/// Ele encapsula toda a lógica visual e comportamental
/// relacionada à entrada de senha, incluindo:
/// - Ocultação/visualização do texto
/// - Validação
/// - Ícones de apoio
///
/// Este componente é reutilizável e desacoplado da lógica
/// de negócio, seguindo o padrão MVVM.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Renderizar campo de entrada de senha
/// - Controlar visibilidade do texto (obscureText)
/// - Executar validação do campo
/// - Disparar ação de alternar visibilidade
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Este arquivo pertence à camada:
/// → Presentation Layer
///
/// Atua como:
/// → UI Component (Widget)
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter/material.dart
///
/// ------------------------------------------------------------
///
/// Dependências recebidas (via parâmetros):
///
/// - TextEditingController
///   → Controle do texto digitado
///
/// - obscureText
///   → Define se a senha está oculta
///
/// - onToggleVisibility
///   → Ação para alternar visibilidade
///
/// - validator
///   → Função de validação do campo
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// LoginPasswordField
///  └── TextFormField
///       ├── prefixIcon (cadeado)
///       ├── suffixIcon (olho)
///       └── validator
///
/// ------------------------------------------------------------
///
/// Funcionamento:
///
/// - Recebe estado do ViewModel (obscureText)
/// - Dispara ação ao clicar no ícone de visibilidade
/// - Executa validação ao submeter formulário
///
/// ------------------------------------------------------------
///
/// Integração com ViewModel:
///
/// ViewModel controla:
/// - obscurePassword
/// - validator
/// - controller
///
/// Widget apenas consome esses dados.
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - StatelessWidget (sem estado interno)
/// - Inversão de controle (callbacks)
/// - Reutilização de componente
/// - Separação de responsabilidades
///
/// ------------------------------------------------------------
///
/// Escalabilidade:
///
/// Pode ser expandido com:
///
/// - Indicador de força da senha
/// - Regras visuais dinâmicas
/// - Integração com autofill
///
/// ------------------------------------------------------------
///
/// O que NÃO deve conter:
///
/// - Estado próprio (setState)
/// - Regras de negócio
/// - Chamadas de API
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
/// 1.0.0  | 18/03/2026 | Francismar  | Criação do campo de senha reutilizável
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

import 'package:flutter/material.dart';

/// Widget responsável pelo campo de senha do login.
class LoginPasswordField extends StatelessWidget {
  /// Controller do campo
  final TextEditingController controller;

  /// Define se o texto está oculto
  final bool obscureText;

  /// Callback para alternar visibilidade
  final VoidCallback onToggleVisibility;

  /// Função de validação
  final String? Function(String?) validator;

  /// Construtor do widget
  const LoginPasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: 'Senha',

        /// Ícone à esquerda
        prefixIcon: const Icon(Icons.lock_outline),

        /// Ícone à direita (toggle)
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}