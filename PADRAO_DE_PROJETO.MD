# PADRÃO MVVM - Arquitetura MVVM associada à Clean Architecture no desenvolvimento de aplicações modernas
# 1. Introdução

A crescente complexidade dos sistemas de software, especialmente no contexto de aplicações móveis, web e sistemas distribuídos, impõe desafios significativos relacionados à organização estrutural, manutenção e evolução contínua do código. Nesse cenário, torna-se imprescindível a adoção de padrões arquiteturais que promovam baixo acoplamento, alta coesão, escalabilidade e testabilidade, características fundamentais para garantir a qualidade e a sustentabilidade de sistemas ao longo do tempo.

Dentre os diversos padrões existentes, destaca-se o Model-View-ViewModel (MVVM), amplamente utilizado no desenvolvimento de interfaces modernas, sobretudo em aplicações orientadas a eventos e com forte interação com o usuário. Esse padrão foi inicialmente popularizado por John Gossman, no contexto das tecnologias da Microsoft, com o objetivo de estabelecer uma clara separação entre a interface gráfica (View) e a lógica de apresentação (ViewModel), reduzindo a dependência direta entre esses componentes e facilitando a reutilização e a testabilidade do código.

Paralelamente, a Clean Architecture, proposta por Robert C. Martin, também conhecido como Uncle Bob, surge como um conjunto de princípios arquiteturais voltados à organização de sistemas em camadas independentes, priorizando as regras de negócio como núcleo da aplicação. Essa abordagem defende que elementos externos, como frameworks, bancos de dados e interfaces de usuário, devem depender das camadas internas, e não o contrário, seguindo o princípio da inversão de dependência.

A integração entre MVVM e Clean Architecture tem se mostrado uma estratégia eficaz no desenvolvimento de aplicações modernas, pois combina a organização da camada de apresentação com uma estrutura robusta de domínio e dados. Enquanto o MVVM atua na separação da interface e da lógica de apresentação, a Clean Architecture amplia essa separação para todo o sistema, garantindo que as regras de negócio permaneçam isoladas de detalhes de implementação.

Nesse contexto, a adoção conjunta dessas abordagens permite a construção de sistemas mais organizados, modulares e resilientes a mudanças. Além disso, facilita a implementação de testes automatizados, a substituição de tecnologias ao longo do tempo e a colaboração entre equipes de desenvolvimento. Portanto, compreender os fundamentos e a aplicação integrada desses padrões é essencial para o desenvolvimento de software de alta qualidade em cenários contemporâneos.

## Estrutura sugerida
## 2. Estrutura Arquitetural Proposta

A organização estrutural apresentada segue uma abordagem modular baseada na integração entre o padrão MVVM e os princípios da Clean Architecture, visando garantir separação de responsabilidades, escalabilidade e facilidade de manutenção. A estrutura do projeto está segmentada em diretórios principais que representam camadas lógicas da aplicação, permitindo uma clara divisão entre interface, regras de negócio e acesso a dados.

No nível mais externo, o diretório `lib/` concentra todo o código-fonte da aplicação, sendo subdividido em quatro módulos principais: `app`, `core`, `features` e o arquivo de entrada `main.dart`. Essa organização favorece a legibilidade e a evolução incremental do sistema.

O diretório `app/` é responsável pela configuração global da aplicação. Nele estão definidos elementos como a inicialização do aplicativo (`app.dart`), o sistema de rotas (`routes/`) e a padronização visual (`theme/`). Essa camada atua como o ponto de integração entre as funcionalidades internas e o framework utilizado, centralizando configurações que impactam toda a aplicação.

O módulo `core/` reúne componentes reutilizáveis e independentes de regras de negócio específicas. Entre eles, destacam-se constantes globais (`constants/`), estruturas auxiliares como o padrão de retorno `Result` (`result/`) e serviços utilitários (`services/`), como validações. Essa camada contribui para a redução de duplicação de código e promove a padronização de comportamentos comuns.

A pasta `features/` representa o núcleo funcional da aplicação, organizada por funcionalidades específicas, como o módulo de autenticação (`auth/`). Essa abordagem orientada a funcionalidades melhora a escalabilidade, pois novas features podem ser adicionadas de forma isolada, sem impactar diretamente outras partes do sistema.

Dentro de cada feature, observa-se a aplicação clara da Clean Architecture, dividida em três subcamadas: `data`, `domain` e `presentation`. A camada `data` é responsável pela comunicação com fontes externas, contendo os *datasources*, modelos de dados e implementações concretas de repositórios. Já a camada `domain` representa o núcleo da lógica de negócio, sendo composta por entidades, contratos de repositórios e casos de uso, mantendo-se independente de frameworks e detalhes externos. Por fim, a camada `presentation` concentra a interface com o usuário, incluindo *views*, *widgets* e *viewmodels*, estes últimos responsáveis por gerenciar o estado e intermediar a comunicação com o domínio.

Adicionalmente, o diretório `di/` (Dependency Injection) dentro de cada feature é responsável pela configuração das dependências, promovendo o desacoplamento entre as camadas por meio da inversão de controle. Essa prática facilita a substituição de implementações e a realização de testes unitários.

Por fim, o arquivo `main.dart` atua como ponto de entrada da aplicação, sendo responsável por inicializar o ambiente e carregar a configuração principal definida na camada `app`.

Em síntese, essa estrutura arquitetural evidencia uma clara separação de responsabilidades, alinhada aos princípios da engenharia de software moderna. A organização por camadas e por funcionalidades contribui significativamente para a manutenção, testabilidade e evolução do sistema, tornando-o adequado para aplicações de médio e grande porte.

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
## 3. Papel do Arquivo `main.dart` na Inicialização da Aplicação

O arquivo `main.dart` constitui o ponto de entrada de uma aplicação desenvolvida com o framework Flutter, desempenhando um papel fundamental na inicialização e execução do sistema. Em termos conceituais, esse arquivo representa o início do ciclo de vida da aplicação, sendo responsável por configurar o ambiente inicial e invocar o componente raiz que dará origem à interface do usuário.

No trecho apresentado, observa-se a definição da função `main()`, que, na linguagem Dart, é obrigatoriamente o ponto inicial de execução de qualquer programa. Essa função é responsável por chamar o método `runApp`, fornecido pelo framework Flutter, que tem como finalidade inserir o widget raiz na árvore de renderização da aplicação.

A chamada `runApp(const IfBankApp());` indica que o widget principal da aplicação é a classe `IfBankApp`, definida em outro módulo (`app/app.dart`). Esse padrão de delegação é uma prática recomendada, pois promove a separação entre a lógica de inicialização e a configuração estrutural da aplicação. Dessa forma, o arquivo `main.dart` mantém-se simples e coeso, atuando exclusivamente como um inicializador, enquanto as responsabilidades mais complexas são delegadas a componentes específicos.

A utilização do modificador `const` na instância de `IfBankApp` está alinhada com boas práticas de desempenho no Flutter, uma vez que permite a otimização de reconstruções da interface, reduzindo o consumo de recursos durante a execução. Esse detalhe evidencia a preocupação com eficiência e aderência aos princípios do framework.

Do ponto de vista arquitetural, o `main.dart` estabelece a ligação entre o ambiente de execução e a estrutura organizada da aplicação, conforme definida pelos padrões MVVM e Clean Architecture. Ele atua como um ponto de integração, garantindo que todas as configurações previamente definidas — como injeção de dependência, rotas e temas — sejam corretamente carregadas a partir do widget principal.

Além disso, essa abordagem favorece a escalabilidade do sistema, pois permite que futuras configurações globais, como inicialização de serviços, configuração de logs, integração com APIs externas ou definição de ambientes (desenvolvimento, homologação e produção), sejam adicionadas de forma controlada dentro da função `main`, sem comprometer a organização do restante do código.

Em síntese, o arquivo `main.dart`, embora simples em sua estrutura, desempenha um papel estratégico na arquitetura da aplicação, funcionando como o ponto de partida que conecta o ambiente de execução à estrutura modular do sistema. Sua correta utilização contribui para a clareza do projeto, a organização do código e a aderência às boas práticas da engenharia de software moderna.

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

