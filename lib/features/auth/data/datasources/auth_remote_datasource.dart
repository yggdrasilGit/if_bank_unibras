/// ============================================================
/// Arquivo: auth_remote_datasource.dart
/// Projeto: IF Bank Mobile Application
///
/// Descricao:
/// Este datasource e responsavel por realizar operacoes remotas
/// de autenticacao contra a API do projeto IF Bank.
///
/// A estrutura base do modulo foi mantida, substituindo o mock
/// original pela integracao HTTP real.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Realizar chamadas remotas de autenticacao
/// - Enviar payloads de login e cadastro
/// - Converter respostas da API em UserEntity
/// - Lancar excecoes amigaveis em caso de erro
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 18/03/2026
/// Ultima modificacao: 30/03/2026
///
/// ------------------------------------------------------------
///
/// Historico de versoes:
///
/// Versao | Data       | Autor       | Descricao
/// 1.0.0  | 18/03/2026 | Francismar  | Implementacao mock do login remoto
/// 1.1.0  | 26/03/2026 | Caio Menin  | Inclusao de mock para cadastro e recuperacao
/// 1.2.0  | 30/03/2026 | Hafrannio   | Integracao com a API real do projeto usando Dio
///
/// ------------------------------------------------------------
///
/// Licenca:
/// MIT License
/// ============================================================
library;

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_request_model.dart';

/// DataSource responsavel por operacoes remotas de autenticacao.
class AuthRemoteDataSource {
  AuthRemoteDataSource([Dio? dio])
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: const {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            );

  final Dio _dio;

  Future<UserEntity> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.login,
        data: request.toMap(),
      );

      return _mapUser(response.data);
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    } catch (_) {
      throw Exception('Nao foi possivel realizar o login.');
    }
  }

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.register,
        data: {
          'full_name': name.trim(),
          'email': email.trim(),
          'password': password,
          'password_confirm': password,
        },
      );

      return _mapUser(response.data);
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    } catch (_) {
      throw Exception('Nao foi possivel realizar o cadastro.');
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    if (email.trim().isEmpty) {
      throw Exception('Informe um e-mail valido.');
    }
  }

  UserEntity _mapUser(Map<String, dynamic>? responseData) {
    final data = responseData ?? const <String, dynamic>{};
    final user = (data['user'] as Map?)?.cast<String, dynamic>() ?? data;

    final id = user['id'];
    final fullName = user['full_name'] ?? user['name'] ?? 'Usuario IF Bank';
    final email = user['email'] ?? '';

    return UserEntity(
      id: '$id',
      name: '$fullName',
      email: '$email',
    );
  }

  String _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }

      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return '${value.first}'.trim();
          }
          if (value is String && value.trim().isNotEmpty) {
            return value.trim();
          }
        }
      }

      final detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail.trim();
      }
    }

    return error.message ?? 'Nao foi possivel concluir a solicitacao.';
  }
}
