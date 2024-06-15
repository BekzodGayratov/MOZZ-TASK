part of 'register_page_cubit.dart';

enum RegisterPageStatus { initial, loading, success, failure }

class RegisterPageState extends Equatable {
  const RegisterPageState(
      {this.status = RegisterPageStatus.initial,
      this.successMessage,
      this.failureMessage,
      this.loading = false});

  RegisterPageState copyWith({
    RegisterPageStatus? status,
    String? successMessage,
    String? failureMessage,
    bool? loading,
  }) {
    return RegisterPageState(
        status: status ?? this.status,
        loading: loading ?? this.loading,
        failureMessage: failureMessage ?? this.failureMessage,
        successMessage: successMessage ?? this.successMessage);
  }

  final RegisterPageStatus status;
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
