import 'package:flutter_test/flutter_test.dart';
import 'package:if_bank/core/results/result.dart';


void main() {
  test('Deve retornar sucesso com dados', () {
    final result = Result.success('Login realizado');

    expect(result.isSuccess, true);
    expect(result.isFailure, false);
    expect(result.data, 'Login realizado');
    expect(result.error, null);
  });

  test('Deve retornar falha com mensagem de erro', () {
  final result = Result.failure('Erro no login');

  expect(result.isSuccess, false);
  expect(result.isFailure, true);
  expect(result.data, null);
  expect(result.error, 'Erro no login');
});

test('Deve funcionar com tipos genéricos diferentes', () {
  final result = Result.success(123);

  expect(result.data, 123);
  expect(result.isSuccess, true);
});


}