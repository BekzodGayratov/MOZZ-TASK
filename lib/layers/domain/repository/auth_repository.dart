import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<String, String>> login({required User user});
}
