import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/repository/auth_repository.dart';

class Login {
  Login({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  Future<Either<String, String>> call({required User user}) async {
    final result = await _repository.login(user: user);

    return result;
  }
}
