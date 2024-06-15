import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/repository/message_repository.dart';

class SendMessage {
  SendMessage({required MessageRepository repository})
      : _repository = repository;
  final MessageRepository _repository;

  Future<Either<String, String>> call({required Message message}) async {
    final result = await _repository.sendMessage(message: message);

    return result;
  }
}
