import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/source/network/auth_service.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImp({required AuthService authService})
      : _authService = authService;

  @override
  Future<Either<String, String>> login({required User user}) async {
    final result = await _authService.login(user: user);
    return result;
  }

  @override
  Future<Either<String, String>> register({required User user}) async {
    final result = await _authService.register(user: user);
    return result;
  }
}
