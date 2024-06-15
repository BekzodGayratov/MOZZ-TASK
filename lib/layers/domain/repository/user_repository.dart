import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/user_dto.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<String, String>> addUserToDB({required User user});
   Future<Either<String, List<UserDto>>> getUsers();
}
