# IF Bank Mobile Application

Aplicação mobile desenvolvida em Flutter, estruturada com MVVM + Clean Architecture, focada em escalabilidade, manutenção e organização por feature.

---

## 1. Tecnologias

* Flutter (SDK >= 3.x)
* Dart
* Provider (Dependency Injection e gerenciamento de estado)
* Material Design 3

---

## 2. Arquitetura

O projeto segue os princípios de Clean Architecture combinados com MVVM.

### Camadas:

* Presentation
  Responsável pela interface do usuário (Views e Widgets)

* ViewModel
  Gerencia estado e regras de apresentação

* Domain
  Contém regras de negócio e contratos (interfaces)

* Data
  Implementações concretas (datasources, repositories)

* Core
  Componentes reutilizáveis globais (services, constants, utils)

---

## 3. Estrutura de Pastas

```text
lib/
├─ app/
│  ├─ app.dart
│  ├─ routes/
│  └─ theme/
│
├─ core/
│  ├─ constants/
│  ├─ result/
│  └─ services/
│
├─ features/
│  └─ auth/
│     ├─ data/
│     ├─ domain/
│     ├─ presentation/
│     └─ di/
│
└─ main.dart
```

---

## 4. Pré-requisitos

Certifique-se de possuir instalado:

* Flutter SDK
* Dart SDK
* Android Studio ou VS Code
* Emulador Android ou dispositivo físico

Verificação:

```bash
flutter doctor
```

---

## 5. Configuração do Ambiente

### Clonar o repositório

```bash
git clone https://github.com/seu-usuario/if-bank-app.git
cd if-bank-app
```

### Instalar dependências

```bash
flutter pub get
```

---

## 6. Execução da Aplicação

```bash
flutter run
```

---

## 7. Credenciais de Teste

```
Email: teste@ifbank.com
Senha: 123456
```

---

## 8. Build

### APK

```bash
flutter build apk
```

### App Bundle

```bash
flutter build appbundle
```

---

## 9. Testes

```bash
flutter test
```

---

## 10. Injeção de Dependência

A aplicação utiliza Provider para gerenciar dependências.

Exemplo:

```dart
MultiProvider(
  providers: AuthInjector.providers,
  child: App(),
)
```

Fluxo de dependência:

View → ViewModel → UseCase → Repository → DataSource

---

## 11. Padrões adotados

* Dependency Injection
* Separation of Concerns
* Single Responsibility Principle
* Feature-based structure
* Baixo acoplamento
* Alta coesão

---

## 12. Convenções de código

* Nomes em inglês
* Classes em PascalCase
* Variáveis e métodos em camelCase
* Estrutura por feature
* Comentários apenas quando necessário

---

## 13. Escalabilidade

O projeto está preparado para evolução com:

* Integração com API real (ex: Dio)
* Armazenamento seguro (Secure Storage)
* Autenticação com JWT
* Refresh Token
* Múltiplos ambientes (dev, hml, prod)
* Modularização por feature

---

## 14. Fluxo de autenticação

1. Usuário insere credenciais
2. ViewModel valida dados
3. UseCase executa regra de negócio
4. Repository decide fonte de dados
5. DataSource simula API
6. Resultado retorna para ViewModel
7. UI reage ao estado

---

## 15. Contribuição

### Criar branch

```bash
git checkout -b feature/nome-da-feature
```

### Commit

```bash
git commit -m "feat: descrição da feature"
```

### Push

```bash
git push origin feature/nome-da-feature
```

### Pull Request

Abrir PR para branch principal

---

## 16. Boas práticas para contribuidores

* Não adicionar lógica na View
* Não acessar DataSource diretamente
* Sempre usar UseCase
* Respeitar separação de camadas
* Manter padrão de arquitetura

---

## 17. Roadmap técnico

* Integração com backend real
* Implementação de autenticação segura
* Implementação de testes unitários
* Implementação de testes de widget
* Implementação de navegação avançada (go_router)

---

## 18. Licença

MIT License

---

## 19. Responsável

Projeto mantido por:

* Professor: Francismar Alves Martins Junior

## 20 Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
