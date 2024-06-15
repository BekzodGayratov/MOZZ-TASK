// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';

class UserDto extends User {
  UserDto({super.email, super.password, super.created_at});

// ---------------------------------------------------------------------------
// JSON
// ---------------------------------------------------------------------------

  factory UserDto.fromRawJson(String str) => UserDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

// ---------------------------------------------------------------------------
// MAP
// ---------------------------------------------------------------------------

  factory UserDto.fromMap(Map<String, dynamic> json) => UserDto(
      email: json['email'],
      password: json['password'],
      created_at: (json['created_at'] as Timestamp).toDate());

  Map<String, dynamic> toMap() =>
      {'email': email, 'password': password, 'created_at': created_at};
}
