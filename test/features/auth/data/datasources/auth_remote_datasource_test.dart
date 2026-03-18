import 'package:flutter_test/flutter_test.dart';
import 'package:if_bank/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:if_bank/features/auth/data/models/login_request_model.dart';


void main() {
  late AuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = AuthRemoteDataSource();
  });

  test('Deve retornar UserEntity quando credenciais forem válidas', () async {
    final request = LoginRequestModel(
      email: 'teste@ifbank.com',
      password: '123456',
    );

    final result = await dataSource.login(request);

    expect(result.email, 'teste@ifbank.com');
    expect(result.name, 'Usuário IF Bank');
    expect(result.id, '1');
  });

  test('Deve lançar Exception quando credenciais forem inválidas', () async {
    final request = LoginRequestModel(
      email: 'errado@ifbank.com',
      password: '000000',
    );

    expect(
      () => dataSource.login(request),
      throwsException,
    );
  });

  test('Deve lançar Exception com mensagem correta', () async {
    final request = LoginRequestModel(
      email: 'errado@ifbank.com',
      password: '000000',
    );

    expect(
      () => dataSource.login(request),
      throwsA(
        isA<Exception>().having(
          (e) => e.toString(),
          'mensagem',
          contains('Credenciais inválidas'),
        ),
      ),
    );
  });
}