/// ============================================================
/// Arquivo: auth_repository.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Contrato da camada de dados para operações de autenticação.
/// Define as assinaturas de login, cadastro e recuperação de senha.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Definir contrato de autenticação
/// - Garantir desacoplamento entre domínio e implementação
/// - Padronizar retornos com Result
///
/// ------------------------------------------------------------
///
/// Arquitetura:
///
/// Camada:
/// -> Data Layer (Contract)
///
/// Papel:
/// -> Repository Interface
///
/// ------------------------------------------------------------
///
/// Dependencias externas:
///
/// - core/results/result.dart
///
/// ------------------------------------------------------------
///
/// Dependencias internas:
///
/// - UserEntity
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// AuthRepository
///  -> login()
///  -> register()
///  -> requestPasswordReset()
///
/// ------------------------------------------------------------
///
/// Restrições:
///
/// Não deve conter:
///
/// - Implementação concreta
/// - Regra de negócio de UI
/// - Dependência de widget
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
/// - Caio Cesar Silva Menin
///
/// Criado em: 18/03/2026
/// Última modificação: 26/03/2026
///
/// ------------------------------------------------------------
///
/// Histórico:
///
/// Versão | Data       | Autor       | Descrição
/// 1.0.0  | 18/03/2026 | Francismar  | Contrato inicial com login
/// 1.1.0  | 26/03/2026 | Caio Menin  | Inclusão de cadastro e recuperação
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required String birthDate,
  });

  Future<Result<String>> requestPasswordReset({
    required String email,
  });
}
