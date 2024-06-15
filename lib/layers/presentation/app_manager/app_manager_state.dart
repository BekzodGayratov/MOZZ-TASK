part of 'app_manager_cubit.dart';

enum AppManagerStatus { initial, done }

class AppManagerState extends Equatable {
  const AppManagerState(
      {this.status = AppManagerStatus.initial,
      this.isAuthorized = false,
      this.loading = false});

  AppManagerState copyWith({
    AppManagerStatus? status,
    bool? isAuthorized,
    bool? loading,
  }) {
    return AppManagerState(
      status: status ?? this.status,
      loading: loading ?? this.loading,
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }

  final AppManagerStatus status;
  final bool isAuthorized;
  final bool loading;

  @override
  List<Object?> get props => [
        status,
        isAuthorized,
        loading,
      ];
}
