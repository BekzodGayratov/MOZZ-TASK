part of 'chat_list_page_cubit.dart';

enum ChatListPageStatus { initial, loading, success, failure }

class ChatListPageState extends Equatable {
  const ChatListPageState(
      {this.status = ChatListPageStatus.initial,
      this.users = const [],
      this.failureMessage,
      this.loading = false});

  ChatListPageState copyWith({
    ChatListPageStatus? status,
    List<User>? users,
    String? failureMessage,
    bool? loading,
  }) {
    return ChatListPageState(
        status: status ?? this.status,
        loading: loading ?? this.loading,
        failureMessage: failureMessage ?? this.failureMessage,
        users: users ?? this.users);
  }

  final ChatListPageStatus status;
  final List<User> users;
  final String? failureMessage;
  final bool loading;

  @override
  List<Object?> get props => [
        status,
        users,
        failureMessage,
        loading,
      ];
}
