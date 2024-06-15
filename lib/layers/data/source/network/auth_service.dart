// ignore_for_file: library_prefixes

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozz_task/layers/domain/entity/user.dart' as userEntity;
import 'package:mozz_task/layers/presentation/singletions.dart';

abstract class AuthService {
  Future<Either<String, String>> login({required userEntity.User user});
  Future<Either<String, String>> register({required userEntity.User user});
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //
  @override
  Future<Either<String, String>> login({required userEntity.User user}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      UserData.initUserData();
      return right('User successfully signed in');
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return left('User not found');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password');
      }
      return left(e.message!);
    }
  }

  @override
  Future<Either<String, String>> register(
      {required userEntity.User user}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      UserData.initUserData();

      return right('User successfully signed in');
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return left('Weak password');
      } else if (e.code == 'email-already-in-use') {
        return left('Email already in use');
      }
      return left(e.message!);
    }
  }
}
