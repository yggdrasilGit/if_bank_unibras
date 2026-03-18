import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:if_bank/app/routes/app_routes.dart';
import 'package:if_bank/features/auth/presentation/views/login_page.dart';

void main() {
  testWidgets('Deve navegar para LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  test('Deve conter rota de login', () {
    final routes = AppRoutes.routes;

    expect(routes.containsKey(AppRoutes.login), true);
  });
}