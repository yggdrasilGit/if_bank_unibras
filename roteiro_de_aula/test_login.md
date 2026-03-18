# 🧪 1. Testes de ViewModel (OS MAIS IMPORTANTES)

Baseada no seu projeto:

```text
test/
├─ core/
│  ├─ services/
│  │  └─ validator_service_test.dart
│  └─ result/
│     └─ result_test.dart
│
├─ features/
│  └─ auth/
│     ├─ data/
│     │  ├─ datasources/
│     │  │  └─ auth_remote_datasource_test.dart
│     │  └─ repositories/
│     │     └─ auth_repository_impl_test.dart
│     │
│     ├─ domain/
│     │  └─ usecases/
│     │     └─ login_usecase_test.dart
│     │
│     └─ presentation/
│        ├─ viewmodels/
│        │  └─ login_viewmodel_test.dart
│        └─ views/
│           └─ login_page_test.dart
│
└─ helpers/
   ├─ mocks/
   │  └─ auth_repository_mock.dart
   └─ fakes/
      ├─ fake_login_usecase.dart
      └─ fake_datasource.dart
```


Aqui você testa a regra da tela sem UI.

📄 `login_viewmodel.dart`

### O que testar:

* validação de formulário
* estado de loading
* sucesso no login
* erro no login
* toggle de senha

### Exemplos:

```dart
test('deve fazer login com sucesso', () async {
  final useCase = FakeLoginUseCaseSuccess();
  final validator = ValidatorService();

  final viewModel = LoginViewModel(
    loginUseCase: useCase,
    validatorService: validator,
  );

  viewModel.emailController.text = 'teste@ifbank.com';
  viewModel.passwordController.text = '123456';

  final result = await viewModel.login();

  expect(result, true);
  expect(viewModel.user, isNotNull);
  expect(viewModel.errorMessage, isNull);
});
```

```dart
test('deve retornar erro quando login falhar', () async {
  final useCase = FakeLoginUseCaseFailure();
  final validator = ValidatorService();

  final viewModel = LoginViewModel(
    loginUseCase: useCase,
    validatorService: validator,
  );

  viewModel.emailController.text = 'errado@ifbank.com';
  viewModel.passwordController.text = '123';

  final result = await viewModel.login();

  expect(result, false);
  expect(viewModel.errorMessage, isNotNull);
});
```

---

# 🧪 2. Testes de UseCase (Regra de negócio)

📄 `login_usecase.dart`

### O que testar:

* se ele chama o repositório corretamente
* se retorna sucesso/erro corretamente

```dart
test('deve chamar o repository', () async {
  final repository = MockAuthRepository();
  final useCase = LoginUseCase(repository: repository);

  await useCase(email: 'a', password: 'b');

  verify(repository.login(email: 'a', password: 'b')).called(1);
});
```

---

# 🧪 3. Testes de Repository

📄 `auth_repository_impl.dart`

### O que testar:

* sucesso vindo do datasource
* tratamento de exceção

```dart
test('deve retornar usuário quando sucesso', () async {
  final datasource = FakeDatasourceSuccess();
  final repository = AuthRepositoryImpl(remoteDataSource: datasource);

  final result = await repository.login(
    email: 'teste@ifbank.com',
    password: '123456',
  );

  expect(result.isSuccess, true);
});
```

```dart
test('deve retornar erro quando exception', () async {
  final datasource = FakeDatasourceFailure();
  final repository = AuthRepositoryImpl(remoteDataSource: datasource);

  final result = await repository.login(
    email: 'x',
    password: 'y',
  );

  expect(result.isFailure, true);
});
```

---

# 🧪 4. Testes de DataSource

📄 `auth_remote_datasource.dart`

Aqui você testa a integração (ou simulação da API).

```dart
test('deve retornar usuário válido', () async {
  final datasource = AuthRemoteDataSource();

  final user = await datasource.login(
    LoginRequestModel(
      email: 'teste@ifbank.com',
      password: '123456',
    ),
  );

  expect(user.email, 'teste@ifbank.com');
});
```

---

# 🧪 5. Testes de Widget (UI)

📄 `login_page.dart` / `login_form.dart`

### O que testar:

* renderização da tela
* clique no botão
* exibição de erro

```dart
testWidgets('deve mostrar botão Entrar', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: LoginPage(),
    ),
  );

  expect(find.text('Entrar'), findsOneWidget);
});
```

```dart
testWidgets('deve mostrar erro quando login falhar', (tester) async {
  await tester.pumpWidget(MyApp());

  await tester.enterText(find.byType(TextFormField).first, 'errado');
  await tester.enterText(find.byType(TextFormField).last, '123');

  await tester.tap(find.text('Entrar'));
  await tester.pump();

  expect(find.textContaining('Credenciais inválidas'), findsOneWidget);
});
```

---

# 🧪 6. Testes de Validação

`validator_service.dart`

```dart
test('email inválido deve retornar erro', () {
  final validator = ValidatorService();

  final result = validator.validateEmail('email errado');

  expect(result, isNotNull);
});
```

---

# 🧪 Resumo (o que você precisa testar)

### 🔹 Camada Presentation

* ViewModel ✅ (PRINCIPAL)
* Widgets

### 🔹 Camada Domain

* UseCases

### 🔹 Camada Data

* Repository
* DataSource

### 🔹 Core

* Validators
* Utils

---

# 🧠 Dica de nível profissional

Para evoluir isso:

* use **mocktail** ou **mockito**
* use **faker** para dados fake
* use **golden tests** para UI
* rode testes no CI/CD

---

# 🚀 Regra de ouro

👉 Se tiver que escolher prioridade:

1. **ViewModel (mais importante)**
2. UseCase
3. Repository
4. Widget
5. DataSource
