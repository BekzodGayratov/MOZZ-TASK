import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/user_dto.dart';
import 'package:mozz_task/layers/domain/repository/user_repository.dart';

class GetUsers {
  GetUsers({required UserRepository repository}) : _repository = repository;
  final UserRepository _repository;

  Future<Either<String, List<UserDto>>> call() async {
    final result = await _repository.getUsers();

    return result;
  }
}
