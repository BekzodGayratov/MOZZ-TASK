import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/usecaces/message/send_message.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required SendMessage sendMessage})
      : _sendMessage = sendMessage,
        super(const SendMessageState());

  final SendMessage _sendMessage;

  Future<void> sendMessage({required Message message}) async {
    emit(state.copyWith(status: SendMessageStatus.loading));

    final result = await _sendMessage(message: message);

    result.fold(
        (l) => emit(state.copyWith(
            status: SendMessageStatus.failure, failureMessage: l)),
        (r) => emit(state.copyWith(
            status: SendMessageStatus.success, successMessage: r)));
  }
}
