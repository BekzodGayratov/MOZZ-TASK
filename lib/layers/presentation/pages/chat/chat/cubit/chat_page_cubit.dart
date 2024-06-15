import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozz_task/layers/data/dto/message_dto.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/usecaces/message/edit_message.dart';
import 'package:mozz_task/layers/domain/usecaces/message/get_messages.dart';

part 'chat_page_state.dart';

class ChatPageCubit extends Cubit<ChatPagePageState> {
  ChatPageCubit(
      {required GetMessages getMessages, required EditMessage editMessage})
      : _getMessages = getMessages,
        _editMessage = editMessage,
        super(const ChatPagePageState());

  // GET MESSAGES
  final GetMessages _getMessages;
  final EditMessage _editMessage;

  Future<void> getUsers(
      {required String? senderId, required String? receiverId}) async {
    emit(state.copyWith(status: ChatPageStatus.loading));

    final result = _getMessages(senderId: senderId, receiverId: receiverId);

    result.fold(
        (l) => emit(
            state.copyWith(status: ChatPageStatus.failure, failureMessage: l)),
        (r) =>
            emit(state.copyWith(status: ChatPageStatus.success, messages: r)));
  }

  // EDIT MESSAGE

  Future<void> editMessage(
      {required String? docId, required Message message}) async {
    emit(state.copyWith(status: ChatPageStatus.loading));

    final result = await _editMessage(docId: docId, message: message);

    result.fold(
      (l) => debugPrint('l'),
      (r) => debugPrint('r'),
    );
  }
}
