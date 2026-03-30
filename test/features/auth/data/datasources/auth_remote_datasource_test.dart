import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:if_bank/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:if_bank/features/auth/data/models/login_request_model.dart';

void main() {
  late AuthRemoteDataSource dataSource;
  late Dio dio;

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://ifbank.test/api/v1',
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final payload = Map<String, dynamic>.from(
            options.data as Map<String, dynamic>,
          );

          final email = payload['email'];
          final password = payload['password'];

          if (email == 'teste@ifbank.com' && password == '123456') {
            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: const {
                  'user': {
                    'id': 1,
                    'full_name': 'Usuario IF Bank',
                    'email': 'teste@ifbank.com',
                  },
                },
              ),
            );
            return;
          }

          handler.reject(
            DioException(
              requestOptions: options,
              response: Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 401,
                data: const {
                  'message': 'Credenciais invalidas',
                },
              ),
              type: DioExceptionType.badResponse,
            ),
          );
        },
      ),
    );

    dataSource = AuthRemoteDataSource(dio);
  });

  test('Deve retornar UserEntity quando credenciais forem validas', () async {
    final request = LoginRequestModel(
      email: 'teste@ifbank.com',
      password: '123456',
    );

    final result = await dataSource.login(request);

    expect(result.email, 'teste@ifbank.com');
    expect(result.name, 'Usuario IF Bank');
    expect(result.id, '1');
  });

  test('Deve lancar Exception quando credenciais forem invalidas', () async {
    final request = LoginRequestModel(
      email: 'errado@ifbank.com',
      password: '000000',
    );

    expect(
      () => dataSource.login(request),
      throwsException,
    );
  });

  test('Deve lancar Exception com mensagem correta', () async {
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
          contains('Credenciais invalidas'),
        ),
      ),
    );
  });
}
