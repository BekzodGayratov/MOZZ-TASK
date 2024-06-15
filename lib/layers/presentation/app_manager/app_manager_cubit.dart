import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';

part 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(const AppManagerState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    if (_auth.currentUser != null) {
      UserData.initUserData();
      emit(state.copyWith(status: AppManagerStatus.done, isAuthorized: true));
    } else {
      emit(state.copyWith(status: AppManagerStatus.done, isAuthorized: false));
    }
  }
}
