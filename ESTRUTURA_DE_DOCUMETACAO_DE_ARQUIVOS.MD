# Documentacao do projeto.

## Modelo de docstring para arquivos Flutter

```dart
/// ============================================================
/// File: user_controller.dart
/// Module: Authentication
///
/// Description:
/// Controller responsible for managing user authentication logic,
/// including login, logout and session validation.
///
/// Features:
/// - User login
/// - User logout
/// - Token validation
/// - Session persistence
///
/// Dependencies:
/// - flutter/material.dart
/// - provider
/// - http
///
/// Author: Seu Nome
/// Created: 2026-03-17
/// Last modified: 2026-03-17
/// Version: 1.0.0
///
/// Notes:
/// This file follows Flutter clean architecture principles.
///
/// License: MIT
/// ============================================================
```

---

# Modelo para Widgets (MUITO IMPORTANTE em Flutter)

## StatelessWidget

````dart
/// Widget responsável por mostrar as informações do usuário.
///
/// Este widget exibe:
/// - Nome
/// - Email
/// - Foto de perfil
///
/// Example:
/// ```dart
/// UserCard(user: user)
/// ```
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
````

---

## StatefulWidget

```dart
/// Tela de login do aplicativo.
///
/// Responsável por:
/// - Capturar credenciais
/// - Validar formulário
/// - Enviar dados para API
/// - Mostrar loading
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
```

---

# Modelo para propriedades

```dart
/// Nome do usuário autenticado.
final String username;

/// Token JWT da sessão atual.
final String token;
```

---

# Modelo para métodos Flutter

```dart
/// Realiza a autenticação do usuário.
///
/// Retorna true se login for bem sucedido.
///
/// Throws:
/// [AuthException] se credenciais inválidas.
Future<bool> login() async {
  return true;
}
```

---

# Modelo recomendado pelo Flutter team (melhor prática)

Este é o padrão **mais correto**:

```dart
/// A widget that displays user profile information.
///
/// This widget shows the user's name, email and avatar.
/// It rebuilds when user data changes.
class ProfileCard extends StatelessWidget {
```

---

# Padrão usado em projetos Flutter profissionais

(este é o melhor template)

```dart
/// Login page of the application.
///
/// Allows the user to authenticate using email and password.
///
/// Responsibilities:
/// * Form validation
/// * Authentication request
/// * Error handling
/// * Navigation after login
///
/// See also:
/// * [AuthService]
/// * [UserRepository]
class LoginPage extends StatefulWidget {}
```

---

# Boas práticas Flutter (nível profissional) 

Sempre documente:

✔ Widgets públicos
✔ Services
✔ Controllers
✔ Repositories
✔ Models
✔ APIs
✔ Métodos complexos

Evite documentar:
UI simples
getters óbvios
código autoexplicativo

---

# Dica MUITO profissional

Use também:

```dart
/// {@template login_page}
/// Login page documentation.
/// {@endtemplate}
```

E reutilize:

```dart
/// {@macro login_page}
```
