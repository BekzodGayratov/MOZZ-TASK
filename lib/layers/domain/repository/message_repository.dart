import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';

abstract class MessageRepository {
Either<String,Stream<List<MessageDto>>> getMessages(
      {required String? senderId, required String? receiverId});
  Future<Either<String, String>> sendMessage({required Message message});
}
