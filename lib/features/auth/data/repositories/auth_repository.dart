import 'package:if_bank/core/results/result.dart';
import 'package:if_bank/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });
}