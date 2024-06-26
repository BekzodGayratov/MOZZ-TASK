part of 'login_page_cubit.dart';

enum LoginPageStatus { initial, loading, success, failure }

class LoginPageState extends Equatable {
  const LoginPageState(
      {this.status = LoginPageStatus.initial,
      this.successMessage,
      this.failureMessage});

  LoginPageState copyWith({
    LoginPageStatus? status,
    String? successMessage,
    String? failureMessage,

  }) {
    return LoginPageState(
        status: status ?? this.status,

        failureMessage: failureMessage ?? this.failureMessage,
        successMessage: successMessage ?? this.successMessage);
  }

  final LoginPageStatus status;
  final String? successMessage;
  final String? failureMessage;


  @override
  List<Object?> get props => [
        status,
        successMessage,
        failureMessage,

      ];
}
