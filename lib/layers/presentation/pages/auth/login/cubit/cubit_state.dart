part of 'cubit_cubit.dart';

enum LoginPageStatus { initial, loading, success, failure }

class LoginPageState extends Equatable {
  const LoginPageState(
      {this.status = LoginPageStatus.initial,
      this.successMessage,
      this.failureMessage,
      this.loading = false});

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? successMessage,
    String? failureMessage,
    bool? loading,
  }) {
    return LoginPageState(
        status: status ?? this.status,
        loading: loading ?? this.loading,
        failureMessage: failureMessage ?? this.failureMessage,
        successMessage: successMessage ?? this.successMessage);
  }

  final LoginPageStatus status;
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
