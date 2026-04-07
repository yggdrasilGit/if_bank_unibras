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
/// 1.2.0  | 30/03/2026 | Hafrannio Rodrigues   | Integracao com a API real do projeto usando Dio
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
    : _dio =
          dio ??
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
      _attachTokenFromResponse(response.data);

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
    required String cpf,
    required String phone,
    required String birthDate,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.register,
        data: {
          'full_name': name.trim(),
          'email': email.trim(),
          'password': password,
          'password_confirm': password,
          'cpf': cpf.replaceAll(RegExp(r'\D'), ''),
          'phone': phone.trim(),
          'birth_date': birthDate.trim(),
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

  Future<Map<String, dynamic>> fetchProfile() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.profile,
      );
      final data = response.data ?? <String, dynamic>{};

      final success = data['success'];
      if (success == false) {
        final message = (data['errors']?['detail'] ?? data['message'] ?? '')
            .toString()
            .trim();
        if (message.isNotEmpty) {
          throw Exception(message);
        }
        throw Exception('Sessao invalida.');
      }

      if (data['user'] is Map<String, dynamic>) {
        return (data['user'] as Map<String, dynamic>);
      }
      return data;
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    } catch (_) {
      throw Exception('Nao foi possivel carregar o perfil.');
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String cpf,
  }) async {
    return patchProfile(
      {
        'full_name': fullName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'cpf': cpf.replaceAll(RegExp(r'\D'), ''),
      },
    );
  }

  Future<void> patchProfile(Map<String, dynamic> data) async {
    try {
      await _dio.patch<Map<String, dynamic>>(
        ApiConstants.profile,
        data: data,
      );
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    } catch (_) {
      throw Exception('Nao foi possivel atualizar o perfil.');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAccounts() async {
    try {
      final response = await _dio.get<dynamic>(ApiConstants.accounts);
      final data = response.data;

      if (data is List) {
        return data.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList();
      }

      if (data is Map<String, dynamic>) {
        final results = data['results'];
        if (results is List) {
          return results.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList();
        }

        final items = data['data'];
        if (items is List) {
          return items.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList();
        }
      }

      return const <Map<String, dynamic>>[];
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    } catch (_) {
      throw Exception('Não foi possível carregar as contas.');
    }
  }

  void clearAuthorization() {
    _dio.options.headers.remove('Authorization');
  }

  bool get hasAuthorization {
    final auth = _dio.options.headers['Authorization'];
    return auth is String && auth.trim().isNotEmpty;
  }

  UserEntity _mapUser(Map<String, dynamic>? responseData) {
    final data = responseData ?? const <String, dynamic>{};
    final user = (data['user'] as Map?)?.cast<String, dynamic>() ?? data;

    final id = user['id'];
    final fullName = user['full_name'] ?? user['name'] ?? 'Usuario IF Bank';
    final email = user['email'] ?? '';

    return UserEntity(id: '$id', name: '$fullName', email: '$email');
  }

  String _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return _localizeErrorMessage('${value.first}'.trim());
          }
          if (value is String && value.trim().isNotEmpty) {
            return _localizeErrorMessage(value.trim());
          }
        }
      }

      // DRF frequentemente retorna erros no formato:
      // {"email": ["..."], "cpf": ["..."]}
      for (final entry in data.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is List && value.isNotEmpty) {
          return _localizeErrorMessage('$key: ${value.first}'.trim());
        }

        if (value is String && value.trim().isNotEmpty) {
          return _localizeErrorMessage('$key: ${value.trim()}');
        }
      }

      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return _localizeErrorMessage(message.trim());
      }

      final detail = data['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return _localizeErrorMessage(detail.trim());
      }
    }

    return _localizeErrorMessage(
      error.message ?? 'Nao foi possivel concluir a solicitacao.',
    );
  }

  void _attachTokenFromResponse(Map<String, dynamic>? data) {
    if (data == null) {
      return;
    }

    final tokens = data['tokens'];
    final accessToken =
        data['access'] ??
        data['token'] ??
        (tokens is Map<String, dynamic> ? tokens['access'] : null);

    if (accessToken is String && accessToken.trim().isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer ${accessToken.trim()}';
    }
  }

  String _localizeErrorMessage(String message) {
    final normalized = message.toLowerCase();

    if (normalized.contains('cpf is invalid')) {
      return 'CPF inválido.';
    }

    if (normalized.contains('already exists') && normalized.contains('cpf')) {
      return 'Já existe um usuário com este CPF.';
    }

    if (normalized.contains('already exists') && normalized.contains('email')) {
      return 'Já existe um usuário com este e-mail.';
    }

    if (normalized.contains('authentication credentials were not provided')) {
      return 'As credenciais de autenticação não foram fornecidas.';
    }

    return message;
  }
}
