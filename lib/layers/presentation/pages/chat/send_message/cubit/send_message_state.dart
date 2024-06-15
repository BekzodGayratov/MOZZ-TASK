part of 'send_message_cubit.dart';

enum SendMessageStatus { initial, loading, success, failure }

class SendMessageState extends Equatable {
  const SendMessageState(
      {this.status = SendMessageStatus.initial,
      this.successMessage,
      this.failureMessage,
      this.loading = false});

  SendMessageState copyWith({
    SendMessageStatus? status,
    String? successMessage,
    String? failureMessage,
  }) {
    return SendMessageState(
        status: status ?? this.status,
        failureMessage: failureMessage ?? this.failureMessage,
        successMessage: successMessage ?? this.successMessage);
  }

  final SendMessageStatus status;
  final String? successMessage;
  final String? failureMessage;
  final bool loading;

  @override
  List<Object?> get props => [
        status,
        successMessage,
        failureMessage,
        loading,
      ];
}
