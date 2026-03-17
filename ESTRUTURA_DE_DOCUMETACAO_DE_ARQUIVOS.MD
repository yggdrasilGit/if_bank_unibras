# Documentacao do projeto.

## Modelo completo de docstring para arquivos

```dart
/// ============================================================
/// Arquivo: nome_do_arquivo.dart
/// Projeto: Nome do Projeto
///
/// Descrição:
/// Este arquivo é responsável por [explicar claramente a função].
/// Ele contém [classes/funções/utilidades] relacionadas a [módulo].
///
/// Responsabilidades:
/// - Gerenciar ...
/// - Processar ...
/// - Validar ...
///
/// Dependências:
/// - package:flutter/material.dart
/// - dart:convert
///
/// Autor(es):
/// - Nome Sobrenome
///
/// Criado em: 17/03/2026
/// Última modificação: 17/03/2026
///
/// Histórico de alterações:
/// Versão    Data        Autor        Descrição
/// 1.0.0     17/03/2026  Seu nome     Criação do arquivo
///
/// Convenções:
/// - Segue padrões do Effective Dart
/// - Null safety habilitado
///
/// Observações:
/// Qualquer informação extra importante.
///
/// Licença:
/// MIT License
/// ============================================================
```

---

## Modelo para documentar CLASSES

````dart
/// Representa um serviço responsável por autenticação.
///
/// Esta classe gerencia:
/// - Login
/// - Logout
/// - Refresh token
///
/// Exemplo:
/// ```dart
/// final auth = AuthService();
/// auth.login("email", "senha");
/// ```
///
/// Autor: Seu nome
class AuthService {

}
````

---

## Modelo para documentar FUNÇÕES

````dart
/// Calcula o total de um pedido.
///
/// Recebe o valor base e aplica impostos.
///
/// Parâmetros:
/// [price] Valor original
/// [tax] Percentual de imposto
///
/// Retorna:
/// Valor final com imposto aplicado.
///
/// Exemplo:
/// ```dart
/// final total = calculateTotal(100, 10);
/// ```
///
/// Throws:
/// Exception se o valor for negativo.
double calculateTotal(double price, double tax) {
  return price + (price * tax / 100);
}
````

---

## Modelo para documentar MÉTODOS

```dart
/// Realiza o login do usuário.
///
/// Retorna true se sucesso.
///
/// Parâmetros:
/// [email] Email do usuário
/// [password] Senha do usuário
///
/// Retorna:
/// bool indicando sucesso.
Future<bool> login(String email, String password) async {
  return true;
}
```

---

## Modelo profissional usado em projetos grandes

(Este é o mais recomendado)

```dart
/// {@category Services}
/// {@subCategory Authentication}
/// {@author Seu Nome}
/// {@version 1.0.0}
///
/// Serviço responsável pelo gerenciamento de autenticação.
```


## Padrão que devs Flutter usam (recomendado)

Este é o estilo mais comum:

```dart
/// Service responsible for user authentication.
///
/// Handles login, logout and token refresh.
class AuthService {}
```

---

## Modelo para Widgets (MUITO IMPORTANTE em Flutter)

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

## Modelo para propriedades

```dart
/// Nome do usuário autenticado.
final String username;

/// Token JWT da sessão atual.
final String token;
```

---

## Modelo para métodos Flutter

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

## Modelo recomendado pelo Flutter team (melhor prática)

Este é o padrão **mais correto**:

```dart
/// A widget that displays user profile information.
///
/// This widget shows the user's name, email and avatar.
/// It rebuilds when user data changes.
class ProfileCard extends StatelessWidget {
```

---

## Padrão usado em projetos Flutter profissionais

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

## Boas práticas Flutter (nível profissional)

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

## Dica MUITO profissional

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
