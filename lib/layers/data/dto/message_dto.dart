// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';

class MessageDto extends Message {
  MessageDto(
      {super.sender_id, super.receiver_id, super.text, super.created_at});

// ---------------------------------------------------------------------------
// JSON
// ---------------------------------------------------------------------------

  factory MessageDto.fromRawJson(String str) =>
      MessageDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

// ---------------------------------------------------------------------------
// MAP
// ---------------------------------------------------------------------------

  factory MessageDto.fromMap(Map<String, dynamic> json) => MessageDto(
      sender_id: json['sender_id'],
      receiver_id: json['receiver_id'],
      text: json['text'],
      created_at: (json['created_at'] as Timestamp).toDate());

  Map<String, dynamic> toMap() => {
        'sender_id': sender_id,
        'receiver_id': receiver_id,
        'text': text,
        'created_at': Timestamp.fromDate(created_at!)
      };
}
