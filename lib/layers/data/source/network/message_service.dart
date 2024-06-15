// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';

abstract class MessageService {
  ////
  Either<String, Stream<List<MessageDto>>> getMessages(
      {required String? senderId, required String? receiverId});

  ////

  Future<Either<String, String>> sendMessage({required Message message});

  ////

  Future<Either<String, String>> editMessage(
      {required String? docId, required Message message});
}

//------------------------------------------------------------------------------
// IMPLEMENTATION
//------------------------------------------------------------------------------

class MessageServiceImpl extends MessageService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Either<String, Stream<List<MessageDto>>> getMessages(
      {required String? senderId, required String? receiverId}) {
    try {
      final result = _firebaseFirestore
          .collection('messages')
          // .where('sender_id', isEqualTo: senderId)
          // .where('receiver_id', isEqualTo: receiverId)
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
  Future<Either<String, String>> sendMessage({required Message message}) async {
    try {
      final result = await _firebaseFirestore.collection('messages').add({
        'sender_id': message.sender_id,
        'receiver_id': message.receiver_id,
        'text': message.text,
        'created_at': DateTime.now()
      });

      return right(result.id);
    } on FirebaseException catch (e) {
      return left(e.message.toString());
    }
  }

  @override
  Future<Either<String, String>> editMessage(
      {required String? docId, required Message message}) async {
    try {
      await _firebaseFirestore.collection('messages').doc(docId).update({
        'sender_id': message.sender_id,
        'receiver_id': message.receiver_id,
        'text': message.text,
        'created_at': DateTime.now()
      });

      return right('Edited successfully');
    } on FirebaseException catch (e) {
      return left(e.message.toString());
    }
  }
}
