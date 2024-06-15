import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/user/get_users.dart';

part 'chat_list_page_state.dart';

class ChatListPageCubit extends Cubit<ChatListPageState> {
  ChatListPageCubit({required GetUsers getUsers})
      : _getUsers = getUsers,
        super(const ChatListPageState());

  final GetUsers _getUsers;
  //

  Future<void> getUsers() async {
    emit(state.copyWith(status: ChatListPageStatus.loading));

    final result = await _getUsers();

    result.fold(
        (l) => emit(state.copyWith(
            status: ChatListPageStatus.failure, failureMessage: l)),
        (r) =>
            emit(state.copyWith(status: ChatListPageStatus.success, users: r)));
  }
}
