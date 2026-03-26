/// ============================================================
/// Arquivo: login_header_test.dart
/// Projeto: IF Bank Mobile Application
///
/// Descrição:
/// Testes de widget para o componente LoginHeader.
///
/// Este arquivo valida se o cabeçalho da tela de login
/// está sendo renderizado corretamente, garantindo que
/// os elementos visuais principais estejam presentes.
///
/// ------------------------------------------------------------
///
/// Responsabilidades:
///
/// - Verificar renderização do logo (SVG)
/// - Validar exibição do nome do aplicativo
/// - Validar exibição do subtítulo de login
/// - Garantir estrutura básica do layout (Column)
/// - Validar presença de espaçamentos (SizedBox)
///
/// ------------------------------------------------------------
///
/// Tipo de teste:
///
/// → Widget Test
///
/// ------------------------------------------------------------
///
/// Componentes testados:
///
/// - LoginHeader
///
/// ------------------------------------------------------------
///
/// Dependências externas:
///
/// - flutter_test
/// - flutter/material.dart
/// - flutter_svg
///
/// ------------------------------------------------------------
///
/// Dependências internas:
///
/// - LoginHeader
/// - AppStrings
///
/// ------------------------------------------------------------
///
/// Boas práticas aplicadas:
///
/// - Testes isolados de UI
/// - Uso de pumpWidget para renderização
/// - Verificação por tipo e conteúdo
/// - Independência de estado (StatelessWidget)
///
/// ------------------------------------------------------------
///
/// Observações:
///
/// - Este teste não valida estilos visuais (cores, fontes)
/// - Não depende de lógica de negócio
/// - Pode falhar caso o asset SVG não esteja configurado
///
/// ------------------------------------------------------------
///
/// Autor(es):
/// - Francismar Alves Martins Junior
///
/// Criado em: 22/03/2026
/// Última modificação: 22/03/2026
///
/// ------------------------------------------------------------
///
/// Licença:
/// MIT License
/// ============================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:if_bank/core/constants/app_strings.dart';
import 'package:if_bank/features/auth/presentation/widgets/login_header.dart';

void main() {
  Widget createWidget() {
    return const MaterialApp(home: Scaffold(body: LoginHeader()));
  }

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Deve renderizar o logo SVG', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('Deve exibir o nome do app', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text(AppStrings.appName), findsOneWidget);
  });

  testWidgets('Deve exibir o subtítulo de login', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text(AppStrings.loginTitle), findsOneWidget);
  });

  testWidgets('Deve conter uma Column', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.byType(Column), findsOneWidget);
  });

  testWidgets('Deve conter espaçamentos corretos', (tester) async {
  await tester.pumpWidget(createWidget());

  expect(find.byWidgetPredicate(
    (widget) => widget is SizedBox && widget.height == 16,
  ), findsOneWidget);

  expect(find.byWidgetPredicate(
    (widget) => widget is SizedBox && widget.height == 8,
  ), findsOneWidget);
});
}
