import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/repository/user_repository.dart';

class AddUserToDB {
  AddUserToDB({required UserRepository repository}) : _repository = repository;
  final UserRepository _repository;

  Future<Either<String, String>> call({required User user}) async {
    final result = await _repository.addUserToDB(user: user);

    return result;
  }
}
