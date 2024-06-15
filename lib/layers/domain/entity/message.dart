// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';

class Message with EquatableMixin {
  final String? sender_id;
  final String? receiver_id;
  final String? text;
  final DateTime? created_at;

  Message({this.sender_id, this.receiver_id, this.text, this.created_at});

  @override
  List<Object?> get props => [sender_id, receiver_id, text, created_at];
}
