import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  final String? email;
  final String? password;
  final String? displayName;

  User({this.email, this.password, this.displayName});

  @override
  List<Object?> get props => [email, password, displayName];
}
