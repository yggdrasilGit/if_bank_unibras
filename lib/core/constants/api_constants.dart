// ============================================================
// Arquivo: lib/core/constants/api_constants.dart
// Projeto: IF Bank Mobile Application
//
// Descricao:
// Este arquivo centraliza a configuracao basica da API consumida
// pelo aplicativo, mantendo a estrutura da equipe sem espalhar
// URLs fixas pelo codigo.
//
// Responsabilidades:
// - Definir a base URL da API.
// - Centralizar endpoints de autenticacao.
// - Permitir override por dart-define.
//
// Dependencias:
// - package:flutter/foundation.dart
//
// Autor(es):
// - Hafrannio Rodrigues
//
// Criado em: 30/03/2026
// Ultima modificacao: 30/03/2026
//
// Historico de alteracoes:
// Versao    Data        Autor                 Descricao
// 1.0.0     30/03/2026  Hafrannio Rodrigues   Criacao da configuracao central da API para integracao com o backend.
//
// Convencoes:
// - Segue padroes do Effective Dart.
// - Null safety habilitado.
//
// Observacoes:
// - Mantido simples para nao desalinhar a estrutura da equipe.
// - Pode ser sobrescrito via --dart-define=API_BASE_URL.
//
// Licenca:
// MIT License
// ============================================================
import 'package:flutter/foundation.dart';

abstract final class ApiConstants {
  static const _definedBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_definedBaseUrl.isNotEmpty) {
      return _definedBaseUrl;
    }

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api/v1';
    }

    // return 'http://127.0.0.1:8000/api/v1';
    return 'http://3.236.172.242/api/v1/';
  }

  // static const login = '/auth/login/';
  // static const register = '/auth/register/';
  static const login = 'auth/login/';
  static const register = 'auth/register/';
  static const profile = 'auth/profile/';
  static const accounts = 'accounts/';
}
