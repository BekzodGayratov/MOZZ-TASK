// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';

abstract class MessageService {
  Either<String, Stream<List<MessageDto>>> getMessages(
      {required String? senderId, required String? receiverId});

  Future<Either<String, String>> sendMessage({required Message message});
}

class MessageServiceImpl extends MessageService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Either<String, Stream<List<MessageDto>>> getMessages(
      {required String? senderId, required String? receiverId}) {
    try {
      final result = _firebaseFirestore
          .collection('messages')
          .where('sender_id', isEqualTo: senderId)
          .where('receiver_id', isEqualTo: receiverId)
          .orderBy('created_at')
          .snapshots()
          .map((QuerySnapshot snapshot) => snapshot.docs
              .map((e) => MessageDto.fromMap(e.data() as Map<String, dynamic>))
              .toList());

      return right(result);
    } on FirebaseException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, String>> sendMessage({required Message message}) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
