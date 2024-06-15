import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/user_dto.dart';
import 'package:mozz_task/layers/data/source/network/user_service.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/repository/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserService _userService;

  UserRepositoryImp({required UserService userService})
      : _userService = userService;

  @override
  Future<Either<String, String>> addUserToDB({required User user}) async {
    final result = await _userService.addUserToDB(user: user);
    return result;
  }

  @override
  Future<Either<String, List<UserDto>>> getUsers() async {
    final result = await _userService.getUsers();
    return result;
  }
}
