import 'package:dartz/dartz.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/repository/message_repository.dart';

class EditMessage {
  EditMessage({required MessageRepository repository})
      : _repository = repository;
  final MessageRepository _repository;

  Future<Either<String, String>> call(
      {required String? docId, required Message message}) async {
    final result =
        await _repository.editMessage(docId: docId, message: message);

    return result;
  }
}
