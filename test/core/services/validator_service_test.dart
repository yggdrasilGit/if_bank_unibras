import 'package:flutter_test/flutter_test.dart';
import 'package:if_bank/core/services/validator_service.dart';

void main() {
  late ValidatorService validator;

  setUp(() {
    validator = ValidatorService();
  });

  group('validateEmail', () {
    test('deve retornar erro quando email for null', () {
      final result = validator.validateEmail(null);
      expect(result, 'Informe seu e-mail');
    });

    test('deve retornar null quando email for válido', () {
      final result = validator.validateEmail('teste@ifbank.com');
      expect(result, isNull);
    });
  });

  group('validatePassword', () {
    test('deve retornar erro quando senha for null', () {
      final result = validator.validatePassword(null);
      expect(result, 'Informe sua senha');
    });

    test('deve retornar null quando senha for válida', () {
      final result = validator.validatePassword('123456');
      expect(result, isNull);
    });
  });
}