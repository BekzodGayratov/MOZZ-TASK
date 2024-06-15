import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/data/source/network/message_service.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/repository/message_repository.dart';

class MessageRepositoryImp implements MessageRepository {
  final MessageService _messageService;

  MessageRepositoryImp({required MessageService messageService})
      : _messageService = messageService;



  @override
  Future<Either<String, String>> sendMessage({required Message message}) async {
    final result = await _messageService.sendMessage(message: message);
    return result;
  }
  
  @override
  Either<String, Stream<List<MessageDto>>> getMessages({required String? senderId, required String? receiverId}) {
   final result =  _messageService.getMessages(
        senderId: senderId, receiverId: receiverId);

    return result;
  }
}
