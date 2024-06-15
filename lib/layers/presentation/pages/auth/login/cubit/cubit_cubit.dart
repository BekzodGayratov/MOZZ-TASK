import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/login.dart';

part 'cubit_state.dart';

class CubitCubit extends Cubit<LoginPageState> {
  CubitCubit({required Login login})
      : _login = login,
        super(const LoginPageState());

  final Login _login;

  Future<void> login({required User user}) async {
    emit(state.copyWith(status: LoginPageStatus.loading));

    final result = await _login(user: user);

    result.fold(
        (l) => emit(
            state.copyWith(status: LoginPageStatus.failure, failureMessage: l)),
        (r) => emit(state.copyWith(
            status: LoginPageStatus.success, successMessage: r)));
  }
}
