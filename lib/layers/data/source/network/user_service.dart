// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozz_task/layers/data/dto/user_dto.dart';
import 'package:mozz_task/layers/domain/entity/user.dart' as userEntity;

abstract class UserService {
  Future<Either<String, String>> addUserToDB({required userEntity.User user});
  Future<Either<String, List<UserDto>>> getUsers();
}

class UserServiceImpl extends UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Either<String, String>> addUserToDB(
      {required userEntity.User user}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .add({'email': user.email, 'created_at': DateTime.now()});

      return right('The user added to DB');
    } on FirebaseException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, List<UserDto>>> getUsers() async {
    try {
      final result = await _firebaseFirestore
          .collection('users')
          .orderBy('created_at')
          .get();

      final modelledData =
          result.docs.map((e) => UserDto.fromMap(e.data())).toList();

      return right(modelledData);
    } on FirebaseAuthException catch (e) {
      return left(e.message.toString());
    }
  }
}
