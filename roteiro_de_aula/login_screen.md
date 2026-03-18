# PADRÃO MVVM

## Estrutura sugerida

```text
lib/
├─ app/
│  ├─ app.dart
│  ├─ routes/
│  │  └─ app_routes.dart
│  └─ theme/
│     └─ app_theme.dart
│
├─ core/
│  ├─ constants/
│  │  └─ app_strings.dart
│  ├─ result/
│  │  └─ result.dart
│  └─ services/
│     └─ validator_service.dart
│
├─ features/
│  └─ auth/
│     ├─ data/
│     │  ├─ datasources/
│     │  │  └─ auth_remote_datasource.dart
│     │  ├─ models/
│     │  │  └─ login_request_model.dart
│     │  └─ repositories/
│     │     └─ auth_repository_impl.dart
│     │
│     ├─ domain/
│     │  ├─ entities/
│     │  │  └─ user_entity.dart
│     │  ├─ repositories/
│     │  │  └─ auth_repository.dart
│     │  └─ usecases/
│     │     └─ login_usecase.dart
│     │
│     ├─ presentation/
│     │  ├─ viewmodels/
│     │  │  └─ login_viewmodel.dart
│     │  ├─ views/
│     │  │  └─ login_page.dart
│     │  └─ widgets/
│     │     ├─ login_form.dart
│     │     ├─ login_header.dart
│     │     └─ login_password_field.dart
│     │
│     └─ di/
│        └─ auth_injector.dart
│
└─ main.dart
```

---

# 1) `main.dart`

```dart
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  runApp(const IfBankApp());
}
```

---

# 2) `app/app.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/di/auth_injector.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class IfBankApp extends StatelessWidget {
  const IfBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AuthInjector.providers,
      child: MaterialApp(
        title: 'IF Bank',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}
```

---

# 3) `app/routes/app_routes.dart`

```dart
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/login_page.dart';

class AppRoutes {
  static const String login = '/';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginPage(),
      };
}
```

---

# 4) `app/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const primaryColor = Color(0xFF0A7E3E);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
```

---

# 5) `core/constants/app_strings.dart`

```dart
class AppStrings {
  static const appName = 'IF Bank';
  static const loginTitle = 'Acesse sua conta';
  static const email = 'E-mail';
  static const password = 'Senha';
  static const signIn = 'Entrar';
  static const forgotPassword = 'Esqueci minha senha';
  static const createAccount = 'Criar conta';
  static const noAccount = 'Ainda não tem conta?';
}
```

---

# 6) `core/result/result.dart`

```dart
class Result<T> {
  final T? data;
  final String? error;

  const Result._({
    this.data,
    this.error,
  });

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  factory Result.success(T data) => Result._(data: data);

  factory Result.failure(String error) => Result._(error: error);
}
```

---

# 7) `core/services/validator_service.dart`

```dart
class ValidatorService {
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu e-mail';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Informe um e-mail válido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe sua senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    return null;
  }
}
```

---

# 8) `features/auth/domain/entities/user_entity.dart`

```dart
class UserEntity {
  final String id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

---

# 9) `features/auth/data/models/login_request_model.dart`

```dart
class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
```

---

# 10) `features/auth/domain/repositories/auth_repository.dart`

```dart
import '../../../../core/result/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });
}
```

---

# 11) `features/auth/data/datasources/auth_remote_datasource.dart`

```dart
import '../../domain/entities/user_entity.dart';
import '../models/login_request_model.dart';

class AuthRemoteDataSource {
  Future<UserEntity> login(LoginRequestModel request) async {
    await Future.delayed(const Duration(seconds: 2));

    if (request.email == 'teste@ifbank.com' &&
        request.password == '123456') {
      return const UserEntity(
        id: '1',
        name: 'Usuário IF Bank',
        email: 'teste@ifbank.com',
      );
    }

    throw Exception('Credenciais inválidas');
  }
}
```

---

# 12) `features/auth/data/repositories/auth_repository_impl.dart`

```dart
import '../../../../core/result/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        LoginRequestModel(
          email: email,
          password: password,
        ),
      );

      return Result.success(user);
    } catch (e) {
      return Result.failure(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
```

---

# 13) `features/auth/domain/usecases/login_usecase.dart`

```dart
import '../../../../core/result/result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({
    required this.repository,
  });

  Future<Result<UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
```

---

# 14) `features/auth/presentation/viewmodels/login_viewmodel.dart`

```dart
import 'package:flutter/material.dart';

import '../../../../core/services/validator_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final ValidatorService validatorService;

  LoginViewModel({
    required this.loginUseCase,
    required this.validatorService,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  UserEntity? _user;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  String? get errorMessage => _errorMessage;
  UserEntity? get user => _user;

  String? validateEmail(String? value) {
    return validatorService.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return validatorService.validatePassword(value);
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> login() async {
    _errorMessage = null;

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    _setLoading(true);

    final result = await loginUseCase(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    _setLoading(false);

    if (result.isFailure) {
      _errorMessage = result.error;
      notifyListeners();
      return false;
    }

    _user = result.data;
    notifyListeners();
    return true;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
```

---

# 15) `features/auth/presentation/widgets/login_header.dart`

```dart
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.account_balance_wallet_rounded,
          size: 72,
          color: Color(0xFF0A7E3E),
        ),
        SizedBox(height: 16),
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.loginTitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
```

---

# 16) `features/auth/presentation/widgets/login_password_field.dart`

```dart
import 'package:flutter/material.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?) validator;

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
        prefixIcon: const Icon(Icons.lock_outline),
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
```

---

# 17) `features/auth/presentation/widgets/login_form.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../viewmodels/login_viewmodel.dart';
import 'login_password_field.dart';

class LoginForm extends StatelessWidget {
  final VoidCallback onForgotPassword;
  final VoidCallback onCreateAccount;
  final VoidCallback onLoginSuccess;

  const LoginForm({
    super.key,
    required this.onForgotPassword,
    required this.onCreateAccount,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (_, viewModel, __) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: viewModel.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: viewModel.validateEmail,
                onChanged: (_) => viewModel.clearError(),
                decoration: const InputDecoration(
                  labelText: AppStrings.email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              LoginPasswordField(
                controller: viewModel.passwordController,
                obscureText: viewModel.obscurePassword,
                onToggleVisibility: viewModel.togglePasswordVisibility,
                validator: viewModel.validatePassword,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onForgotPassword,
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),
              if (viewModel.errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  viewModel.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        final success = await viewModel.login();
                        if (success) {
                          onLoginSuccess();
                        }
                      },
                child: viewModel.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text(AppStrings.signIn),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.noAccount),
                  TextButton(
                    onPressed: onCreateAccount,
                    child: const Text(AppStrings.createAccount),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
```

---

# 18) `features/auth/presentation/views/login_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_viewmodel.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LoginHeader(),
                      const SizedBox(height: 32),
                      LoginForm(
                        onForgotPassword: () {
                          _showMessage(context, 'Fluxo de recuperação em construção.');
                        },
                        onCreateAccount: () {
                          _showMessage(context, 'Fluxo de cadastro em construção.');
                        },
                        onLoginSuccess: () {
                          final userName = viewModel.user?.name ?? 'Usuário';
                          _showMessage(
                            context,
                            'Bem-vindo, $userName!',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

# 19) `features/auth/di/auth_injector.dart`

```dart
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../core/services/validator_service.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/viewmodels/login_viewmodel.dart';

class AuthInjector {
  static List<SingleChildWidget> get providers => [
        Provider<ValidatorService>(
          create: (_) => ValidatorService(),
        ),
        Provider<AuthRemoteDataSource>(
          create: (_) => AuthRemoteDataSource(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: context.read<AuthRemoteDataSource>(),
          ),
        ),
        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
            repository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(
            loginUseCase: context.read<LoginUseCase>(),
            validatorService: context.read<ValidatorService>(),
          ),
        ),
      ];
}
```

## Classe abstarata 
´´´dart
import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });
}
```

---

## `pubspec.yaml`

Adicione o `provider`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
```

---

## Por que isso escala melhor

Esse padrão já separa bem:

**View**

* só renderiza interface

**ViewModel**

* controla estado, loading, erro, ação de login

**Domain**

* regras de negócio e contratos

**Data**

* datasource e implementação do repositório

**Core**

* utilitários compartilhados

Assim, quando você crescer o projeto, fica fácil adicionar:

* autenticação real com API
* token JWT
* refresh token
* cache local
* biometria
* interceptors
* ambiente dev/hml/prod
* testes unitários e widget tests

---

## Próximo nível para banco digital

Para um app bancário, eu recomendo depois evoluir para:

* `go_router`
* `dio`
* `get_it` ou `injectable`
* `freezed`
* `json_serializable`
* `flutter_secure_storage`

