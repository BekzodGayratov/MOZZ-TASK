import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/domain/repository/message_repository.dart';

class GetMessages {
  GetMessages({required MessageRepository repository})
      : _repository = repository;
  final MessageRepository _repository;

  Either<String, Stream<List<MessageDto>>> call(
      {required String? senderId,required String? receiverId})  {
    final result =  _repository.getMessages(
        senderId: senderId, receiverId: receiverId);

    return result;
  }
}
