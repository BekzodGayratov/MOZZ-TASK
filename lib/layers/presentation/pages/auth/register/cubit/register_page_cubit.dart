import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/auth/register.dart';
import 'package:mozz_task/layers/domain/usecaces/user/add_user_to_db.dart';

part 'register_page_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit(
      {required Register register, required AddUserToDB addUserToDB})
      : _register = register,
        _addUserToDB = addUserToDB,
        super(const RegisterPageState());

  final Register _register;
  final AddUserToDB _addUserToDB;

  Future<void> register({required User user}) async {
    emit(state.copyWith(status: RegisterPageStatus.loading));

    final result = await _register(user: user);

    result.fold(
        (l) => emit(state.copyWith(
            status: RegisterPageStatus.failure, failureMessage: l)), (r) async {
      final resultOfAddingUser = await _addUserToDB(user: user);

      resultOfAddingUser.fold(
          (l) => debugPrint(l), (r) => debugPrint('User added to database'));
      emit(state.copyWith(
          status: RegisterPageStatus.success, successMessage: r));
    });
  }
}
