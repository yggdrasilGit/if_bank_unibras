# 1) Estrutura nova

Dentro de `features/auth`, adicione:

```text
auth/
├─ data/
│  ├─ datasources/
│  │  └─ auth_remote_datasource.dart   (vamos expandir)
│  ├─ models/
│  │  └─ register_request_model.dart   
│
├─ domain/
│  └─ usecases/
│     └─ register_usecase.dart         
│
├─ presentation/
│  ├─ viewmodels/
│  │  └─ register_viewmodel.dart       
│  ├─ views/
│  │  └─ register_page.dart            
│  └─ widgets/
│     └─ register_form.dart            
```

---

# 2) Model de cadastro

## `register_request_model.dart`

```dart
class RegisterRequestModel {
  final String name;
  final String email;
  final String password;

  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
```

---

# 3) Mock de banco (fake storage)

Vamos simular um “banco” dentro do datasource:

## Atualize `auth_remote_datasource.dart`

```dart
class AuthRemoteDataSource {
  final List<UserEntity> _users = [
    const UserEntity(
      id: '1',
      name: 'Usuário IF Bank',
      email: 'teste@ifbank.com',
    ),
  ];

  Future<UserEntity> login(LoginRequestModel request) async {
    await Future.delayed(const Duration(seconds: 2));

    final user = _users.firstWhere(
      (u) =>
          u.email == request.email &&
          request.password == '123456',
      orElse: () => throw Exception('Credenciais inválidas'),
    );

    return user;
  }

  Future<UserEntity> register(RegisterRequestModel request) async {
    await Future.delayed(const Duration(seconds: 2));

    final emailExists =
        _users.any((u) => u.email == request.email);

    if (emailExists) {
      throw Exception('E-mail já cadastrado');
    }

    final newUser = UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: request.name,
      email: request.email,
    );

    _users.add(newUser);

    return newUser;
  }
}
```

---

# 4) Atualizar Repository

## `auth_repository.dart`

```dart
Future<Result<UserEntity>> register({
  required String name,
  required String email,
  required String password,
});
```

---

## `auth_repository_impl.dart`

```dart
@override
Future<Result<UserEntity>> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final user = await remoteDataSource.register(
      RegisterRequestModel(
        name: name,
        email: email,
        password: password,
      ),
    );

    return Result.success(user);
  } catch (e) {
    return Result.failure(
      e.toString().replaceFirst('Exception: ', ''),
    );
  }
}
```

---

# 5) UseCase

## `register_usecase.dart`

```dart
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({
    required this.repository,
  });

  Future<Result<UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
```

---

# 6) ViewModel

## `register_viewmodel.dart`

```dart
class RegisterViewModel extends ChangeNotifier {
  final RegisterUseCase registerUseCase;
  final ValidatorService validatorService;

  RegisterViewModel({
    required this.registerUseCase,
    required this.validatorService,
  });

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe seu nome';
    }
    return null;
  }

  String? validateEmail(String? value) {
    return validatorService.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return validatorService.validatePassword(value);
  }

  Future<bool> register() async {
    _errorMessage = null;

    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return false;

    _setLoading(true);

    final result = await registerUseCase(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    _setLoading(false);

    if (result.isFailure) {
      _errorMessage = result.error;
      notifyListeners();
      return false;
    }

    return true;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
```

---

# 7) Tela de cadastro

## `register_page.dart`

```dart
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: viewModel.nameController,
                validator: viewModel.validateName,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.emailController,
                validator: viewModel.validateEmail,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: viewModel.passwordController,
                obscureText: true,
                validator: viewModel.validatePassword,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final success = await viewModel.register();
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

# 8) Injeção de dependência

Atualize `auth_injector.dart`:

```dart
Provider<RegisterUseCase>(
  create: (context) => RegisterUseCase(
    repository: context.read<AuthRepository>(),
  ),
),

ChangeNotifierProvider<RegisterViewModel>(
  create: (context) => RegisterViewModel(
    registerUseCase: context.read<RegisterUseCase>(),
    validatorService: context.read<ValidatorService>(),
  ),
),
```

---

# 9) Rota

## `app_routes.dart`

```dart
static const String register = '/register';

routes => {
  login: (_) => const LoginPage(),
  register: (_) => const RegisterPage(),
};
```

---

# 10) Navegar do login

No `LoginForm`:

```dart
onCreateAccount: () {
  Navigator.pushNamed(context, AppRoutes.register);
},
```

