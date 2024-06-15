// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  final String? email;
  final String? password;
  final DateTime? created_at;

  User({this.email, this.password, this.created_at});

  @override
  List<Object?> get props => [email, password, created_at];
}
