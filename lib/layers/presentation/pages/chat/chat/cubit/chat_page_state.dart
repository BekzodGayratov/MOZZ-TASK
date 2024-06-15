part of 'chat_page_cubit.dart';

enum ChatPageStatus { initial, loading, success, failure }

class ChatPagePageState extends Equatable {
  const ChatPagePageState(
      {this.status = ChatPageStatus.initial,
      this.messages,
      this.failureMessage,
      this.loading = false});

  ChatPagePageState copyWith({
    ChatPageStatus? status,
    Stream<List<MessageDto>>? messages,
    String? failureMessage,
    bool? loading,
  }) {
    return ChatPagePageState(
        status: status ?? this.status,
        loading: loading ?? this.loading,
        failureMessage: failureMessage ?? this.failureMessage,
        messages: messages ?? this.messages);
  }

  final ChatPageStatus status;
  final Stream<List<MessageDto>>? messages;
  final String? failureMessage;
  final bool loading;

  @override
  List<Object?> get props => [
        status,
        messages,
        failureMessage,
        loading,
      ];
}
