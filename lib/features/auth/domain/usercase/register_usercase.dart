/// ============================================================
/// Arquivo: register_usercase.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// UseCase responsável por executar o fluxo de cadastro.
/// Orquestra a chamada ao repositório de autenticação.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Executar cadastro de usuário
/// - Encapsular regra de aplicação do cadastro
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
/// - UserEntity
/// - Result
///
/// ------------------------------------------------------------
///
/// Estrutura:
///
/// RegisterUseCase
///  -> repository
///  -> call(name, email, password)
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
/// 1.0.0  | 26/03/2026 | Caio Menin  | Criação do usecase de cadastro
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================

library;

import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/data/repositories/auth_repository.dart';
import 'package:if_bank/features/auth/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({
    required this.repository,
  });

  Future<Result<UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required String cpf,
    required String phone,
    required String birthDate,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      cpf: cpf,
      phone: phone,
      birthDate: birthDate,
    );
  }
}
