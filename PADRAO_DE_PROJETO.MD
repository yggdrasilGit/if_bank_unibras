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

## 4. Componente Central da Aplicação: Análise do arquivo app/app.dart

O arquivo app.dart desempenha um papel central na arquitetura da aplicação, sendo responsável por configurar o widget raiz e estabelecer os principais elementos estruturais do sistema, como gerenciamento de estado, roteamento e padronização visual. No contexto de aplicações Flutter organizadas segundo os princípios do MVVM e da Clean Architecture, esse componente atua como o ponto de integração entre as camadas internas e o framework.

A classe IfBankApp é definida como um StatelessWidget, o que indica que sua construção não depende de estados mutáveis internos. Essa escolha é coerente com sua responsabilidade arquitetural, uma vez que o objetivo dessa classe não é gerenciar lógica de negócio, mas sim estruturar e configurar a aplicação de forma global.

Um dos aspectos mais relevantes observados nesse componente é a utilização do MultiProvider, proveniente da biblioteca Provider. Esse recurso implementa o padrão de injeção de dependência, permitindo que múltiplas instâncias de serviços e objetos sejam disponibilizadas de forma centralizada para toda a árvore de widgets. As dependências são configuradas por meio do AuthInjector.providers, o que evidencia uma separação clara entre a definição das dependências e seu consumo, promovendo baixo acoplamento e maior testabilidade.

A presença da injeção de dependência nesse nível da aplicação segue boas práticas descritas por Martin Fowler, ao permitir que componentes não instanciem diretamente suas dependências, mas as recebam de forma externa. Isso facilita a substituição de implementações e a realização de testes unitários com mocks.

Outro elemento fundamental é o uso do widget MaterialApp, que configura aspectos essenciais da aplicação, tais como:

Título da aplicação (title): utilizado principalmente pelo sistema operacional para identificação.
Remoção do banner de debug (debugShowCheckedModeBanner): prática comum em ambientes de produção.
Tema global (theme): definido por meio de AppTheme.lightTheme, garantindo consistência visual.
Roteamento (routes e initialRoute): responsável pela navegação entre telas.

A definição de rotas por meio da classe AppRoutes contribui para a centralização do controle de navegação, evitando a dispersão de caminhos e facilitando a manutenção do sistema. Esse tipo de organização está alinhado com princípios de modularidade e clareza estrutural.

Do ponto de vista arquitetural, o app.dart funciona como um orquestrador global, conectando a camada de apresentação às configurações essenciais do sistema. Ele garante que todas as dependências estejam disponíveis antes da renderização da interface, além de estabelecer padrões consistentes de navegação e aparência.

Adicionalmente, ao delegar responsabilidades específicas para outros módulos — como AuthInjector, AppRoutes e AppTheme —, o componente reforça o princípio da separação de responsabilidades, evitando concentração excessiva de lógica em um único ponto do sistema.

Em síntese, o arquivo app.dart representa um elemento estratégico na arquitetura da aplicação, sendo responsável por integrar os diferentes componentes do sistema de forma coesa e organizada. Sua estrutura evidencia a aplicação de boas práticas de engenharia de software, contribuindo para a construção de aplicações escaláveis, testáveis e de fácil manutenção.

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

## 5. Gerenciamento de Navegação: Análise do arquivo `app_routes.dart`

O gerenciamento de navegação é um dos aspectos fundamentais no desenvolvimento de aplicações modernas, especialmente em interfaces baseadas em múltiplas telas. No contexto do framework Flutter, esse controle é frequentemente realizado por meio de sistemas de rotas, que permitem a transição estruturada entre diferentes páginas da aplicação. O arquivo `app_routes.dart` exemplifica uma abordagem organizada e centralizada para a definição dessas rotas.

A classe `AppRoutes` atua como um ponto único de configuração da navegação, concentrando as definições de caminhos (*routes*) utilizados no sistema. Essa centralização segue boas práticas de engenharia de software, pois evita a dispersão de strings de navegação ao longo do código, reduzindo erros e facilitando a manutenção.

Inicialmente, observa-se a declaração de uma constante estática:

```dart
static const String login = '/';
```

Essa constante representa a rota inicial da aplicação, associada à tela de login. A utilização de constantes nomeadas, em vez de strings literais diretamente no código, promove maior legibilidade e reduz o risco de inconsistências, especialmente em aplicações de maior porte.

Em seguida, a classe define um *getter* estático denominado `routes`, que retorna um mapa (`Map<String, WidgetBuilder>`). Esse mapa estabelece a correspondência entre as rotas nomeadas e os respectivos construtores de widgets responsáveis por renderizar cada tela:

```dart
static Map<String, WidgetBuilder> get routes => {
  login: (_) => const LoginPage(),
};
```

Nesse contexto, a chave do mapa representa o caminho da rota (por exemplo, `/`), enquanto o valor é uma função que retorna o widget associado, neste caso, a `LoginPage`. O uso de `WidgetBuilder` permite que o Flutter construa a interface dinamicamente quando a rota é acessada, otimizando o uso de recursos.

A adoção dessa abordagem apresenta diversas vantagens. Primeiramente, contribui para a separação de responsabilidades, uma vez que a lógica de navegação é isolada em um módulo específico, distinto das camadas de apresentação e de negócio. Em segundo lugar, facilita a escalabilidade do sistema, pois novas rotas podem ser adicionadas de maneira estruturada, sem impactar diretamente outras partes da aplicação.

Além disso, essa estratégia está alinhada com os princípios da Clean Architecture, ao evitar o acoplamento direto entre a navegação e os componentes de interface. As telas são referenciadas de forma indireta por meio de rotas nomeadas, permitindo maior flexibilidade na substituição ou reorganização de componentes.

Outro aspecto relevante é a compatibilidade dessa abordagem com sistemas de navegação mais avançados, como *navigation stacks*, *middlewares* e controle de acesso a rotas (por exemplo, autenticação). A centralização das rotas facilita a implementação futura dessas funcionalidades, contribuindo para a evolução do sistema.

Em síntese, o arquivo `app_routes.dart` desempenha um papel essencial na organização da navegação da aplicação, fornecendo uma estrutura clara, centralizada e extensível. Sua utilização está alinhada às boas práticas de desenvolvimento em Flutter e aos princípios da engenharia de software moderna, promovendo um código mais limpo, reutilizável e de fácil manutenção.


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

## 6. Padronização Visual: Análise do arquivo `app_theme.dart`

A definição de um sistema de identidade visual consistente é um elemento essencial no desenvolvimento de aplicações modernas, especialmente no contexto de interfaces centradas no usuário. O arquivo `app_theme.dart` tem como principal objetivo estabelecer um padrão visual global para a aplicação, promovendo uniformidade estética, reutilização de estilos e facilidade de manutenção. Essa abordagem está alinhada com os princípios de design de software e com as diretrizes do *Material Design*, amplamente utilizadas no ecossistema Flutter.

A classe `AppTheme` centraliza a configuração do tema da aplicação por meio de um *getter* estático denominado `lightTheme`, que retorna uma instância de `ThemeData`. Essa estratégia permite que o tema seja facilmente acessado e aplicado no widget principal da aplicação, garantindo que todos os componentes herdem as mesmas definições visuais.

Um dos primeiros elementos definidos é a cor primária da aplicação (`primaryColor`), utilizada como base para a geração do esquema de cores. A utilização do método `ColorScheme.fromSeed` permite derivar automaticamente uma paleta harmônica a partir de uma única cor base, o que contribui para a consistência visual e reduz a necessidade de definição manual de múltiplas cores. Esse mecanismo está alinhado com as práticas modernas de design sistematizado.

A propriedade `useMaterial3: true` indica a adoção da versão mais recente do Material Design, que introduz melhorias significativas em termos de usabilidade, acessibilidade e estética. Essa escolha demonstra uma preocupação com a atualização tecnológica e com a aderência às melhores práticas de design de interface.

Além da paleta de cores, o tema define o `scaffoldBackgroundColor`, responsável pela cor de fundo padrão das telas. Essa configuração garante uniformidade visual entre diferentes páginas, evitando inconsistências que poderiam comprometer a experiência do usuário.

Outro aspecto relevante é a personalização do `InputDecorationTheme`, que padroniza a aparência dos campos de entrada de texto. A definição de bordas com cantos arredondados (`OutlineInputBorder` com `borderRadius`) contribui para uma interface mais moderna e amigável. A aplicação consistente desse estilo em estados diferentes (habilitado e focado) reforça a previsibilidade visual e melhora a usabilidade.

No que diz respeito aos botões, o `ElevatedButtonThemeData` estabelece padrões como tamanho mínimo e formato, garantindo que todos os botões elevados da aplicação apresentem comportamento e aparência uniformes. Essa padronização reduz a duplicação de código e facilita ajustes futuros no design.

Adicionalmente, o `CardThemeData` define características visuais dos componentes do tipo *card*, como elevação e arredondamento das bordas. Esses elementos são fundamentais para a hierarquia visual da interface, ajudando a destacar conteúdos e organizar informações de maneira clara.

Do ponto de vista arquitetural, a centralização das definições de tema em um único arquivo está em conformidade com o princípio da **separação de responsabilidades**, pois isola a lógica de apresentação visual das demais camadas da aplicação. Isso facilita a manutenção e permite a evolução do design sem impactar diretamente a lógica de negócio ou a estrutura da interface.

Em síntese, o arquivo `app_theme.dart` desempenha um papel estratégico na construção da identidade visual da aplicação, promovendo consistência, reutilização e alinhamento com padrões modernos de design. Sua utilização contribui significativamente para a qualidade da experiência do usuário e para a organização geral do código, sendo uma prática recomendada em projetos que buscam escalabilidade e profissionalismo.


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

## 7. Centralização de Constantes Textuais: Análise do arquivo `app_strings.dart`

A organização e padronização de textos em aplicações de software constituem uma prática fundamental para garantir consistência, manutenibilidade e preparação para internacionalização. O arquivo `app_strings.dart` exemplifica essa abordagem ao centralizar todas as mensagens e rótulos utilizados na interface do usuário em uma única classe, denominada `AppStrings`.

A classe é composta exclusivamente por constantes estáticas (`static const`), o que indica que seus valores são imutáveis e podem ser acessados diretamente sem a necessidade de instanciamento. Essa escolha está alinhada com boas práticas de desenvolvimento, pois reduz o consumo de memória, evita duplicação de dados e melhora o desempenho geral da aplicação.

Cada constante definida representa um elemento textual da interface, como títulos, rótulos de campos, botões e mensagens auxiliares. Por exemplo, `appName` define o nome da aplicação, enquanto `loginTitle`, `email` e `password` correspondem a elementos presentes na tela de autenticação. Essa estrutura permite que os textos sejam reutilizados em diferentes partes do sistema de forma consistente.

Do ponto de vista arquitetural, a centralização dessas strings contribui diretamente para o princípio da **separação de responsabilidades**, uma vez que remove da camada de apresentação (View) a responsabilidade de definir conteúdos textuais. Em vez disso, a interface passa a consumir valores previamente definidos, tornando o código mais limpo, legível e organizado.

Além disso, essa abordagem facilita significativamente a manutenção do sistema. Alterações em textos — como correções, ajustes de linguagem ou mudanças de nomenclatura — podem ser realizadas em um único local, refletindo automaticamente em toda a aplicação. Isso reduz o risco de inconsistências e erros humanos, especialmente em projetos de maior escala.

Outro aspecto relevante é a preparação para **internacionalização (i18n)** e **localização (l10n)**. Embora o arquivo atual contenha apenas textos em um único idioma, sua estrutura permite uma evolução futura para suporte multilíngue. Nesse cenário, as constantes poderiam ser substituídas ou integradas a sistemas de tradução, sem a necessidade de modificar diretamente os componentes da interface.

Adicionalmente, o uso de constantes nomeadas melhora a legibilidade do código, tornando-o mais autoexplicativo. Em vez de utilizar strings literais dispersas, o desenvolvedor trabalha com identificadores semânticos, o que facilita a compreensão do propósito de cada elemento textual.

Em síntese, o arquivo `app_strings.dart` desempenha um papel importante na organização da camada de apresentação, promovendo padronização, reutilização e facilidade de manutenção. Sua adoção está alinhada às boas práticas da engenharia de software moderna, contribuindo para a construção de aplicações mais estruturadas, escaláveis e preparadas para evolução futura.


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

