/// ============================================================
/// Arquivo: request_password_reset_usercase.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// UseCase responsável por iniciar o fluxo de recuperação de senha.
/// Encapsula a chamada ao repositório para envio das instruções.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Executar solicitação de recuperação de senha
/// - Encapsular regra de aplicação
/// - Retornar resultado padronizado
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// -> Domain Layer
///
/// Papel:
/// -> UseCase
///
/// ------------------------------------------------------------
///
/// Dependencias internas:
///
/// - AuthRepository
/// - Result
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// RequestPasswordResetUseCase
///  -> repository
///  -> call(email)
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Não deve conter:
///
/// - Widgets
/// - Estado de UI
/// - Dependência de Flutter
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 26/03/2026
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação do usecase de recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

library;

import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/data/repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  final AuthRepository repository;

  RequestPasswordResetUseCase({
    required this.repository,
  });

  Future<Result<String>> call({
    required String email,
  }) {
    return repository.requestPasswordReset(email: email);
  }
}
