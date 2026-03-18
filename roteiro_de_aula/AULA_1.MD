# Aula: Entendendo o main.dart no Flutter (IF Bank)

## Objetivo da aula

Explicar o papel do `main.dart` dentro da arquitetura MVVM + Clean Architecture.

---

# Introdução

## Fala:

"Todo app Flutter começa pelo main.dart, mas muita gente não entende o real papel dele."

"Hoje eu vou te mostrar como usar esse arquivo da forma correta em um projeto profissional."

---

# Mostrar o código

```dart
import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  runApp(const IfBankApp());
}
```

---

# Parte 1 — O que é o main.dart?

## Fala:

"O main.dart é o ponto de entrada da aplicação."

## Explicação:

* Todo app Dart começa pela função `main()`
* No Flutter, é onde a UI começa

## Frase forte:

"Se o app fosse um carro, o main.dart seria a chave de ignição."

---

# Parte 2 — Entendendo o main()

## Fala:

"Aqui a gente inicia o app com runApp()."

## Código:

```dart
void main() {
  runApp(const IfBankApp());
}
```

## Explicação:

* `runApp()` inicia a árvore de widgets
* Ele recebe o widget raiz da aplicação

---

# Parte 3 — O que é o IfBankApp?

## Fala:

"O main.dart não configura nada, ele apenas delega."

## Explicação:

* O `IfBankApp` está no arquivo `app.dart`
* Ele contém:

  * Provider
  * Tema
  * Rotas

## Frase forte:

"main.dart chama, app.dart configura."

---

# Parte 4 — O que NÃO fazer no main.dart

## Fala:

"Aqui é onde muita gente erra."

## Nunca fazer:

* Lógica de negócio
* Chamadas de API
* Providers
* Configuração de rotas

## Frase forte:

"Se tem lógica aqui, seu projeto já começou errado."

---

# Parte 5 — Fluxo da aplicação

## Fala:

"Vamos entender o fluxo completo."

## Fluxo:

```text
main.dart
→ runApp()
→ IfBankApp
→ MaterialApp
→ Rotas
→ Tela de Login
```

## Frase forte:

"O main apenas inicia, o resto acontece depois."

---

# Parte 6 — Papel na arquitetura

## Fala:

"Na Clean Architecture, esse arquivo é o bootstrap da aplicação."

## Explicação:

* Ele apenas inicializa o sistema
* Não pertence ao domínio
* Não contém regras de negócio

---

# Parte 7 — Por que manter simples?

## Fala:

"Quanto mais simples, mais escalável."

## Explicação:

Se o arquivo crescer:

* dificulta manutenção
* dificulta testes
* quebra a arquitetura

---

# Encerramento

## Fala:

"Se você quer um projeto profissional, comece simples pelo main.dart."

"No próximo passo, vamos entender o app.dart, que é onde a aplicação realmente começa."

---

# Resumo da aula

* `main.dart` é o ponto de entrada
* Usa `runApp()`
* Chama o widget raiz
* Não contém lógica
* Faz parte do bootstrap

---

# Versão curta (para conteúdo rápido)

## Fala:

"Seu main.dart deveria ser só isso aqui."

```dart
void main() {
  runApp(const IfBankApp());
}
```

"Se tiver mais coisa, você está fazendo errado."