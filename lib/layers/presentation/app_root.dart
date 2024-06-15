import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozz_task/layers/data/auth_repository_impl.dart';
import 'package:mozz_task/layers/data/message_repository_impl.dart';
import 'package:mozz_task/layers/data/source/network/auth_service.dart';
import 'package:mozz_task/layers/data/source/network/message_service.dart';
import 'package:mozz_task/layers/data/source/network/user_service.dart';
import 'package:mozz_task/layers/data/user_repository_iml.dart';
import 'package:mozz_task/layers/domain/repository/message_repository.dart';
import 'package:mozz_task/layers/domain/usecaces/auth/login.dart';
import 'package:mozz_task/layers/domain/usecaces/auth/register.dart';
import 'package:mozz_task/layers/domain/usecaces/message/get_messages.dart';
import 'package:mozz_task/layers/domain/usecaces/user/add_user_to_db.dart';
import 'package:mozz_task/layers/domain/usecaces/user/get_users.dart';
import 'package:mozz_task/layers/presentation/app_manager/app_manager_cubit.dart';
import 'package:mozz_task/layers/presentation/pages/auth/login/view/login_page.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_list/chat_list_page.dart';
import 'package:mozz_task/layers/presentation/style/theme.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final Login _login;
  late final Register _register;
  late final AddUserToDB _addUserToDB;
  late final GetUsers _getUsers;
  late final AuthRepositoryImp _authRepo;
  late final UserRepositoryImp _userRepo;
  late final MessageRepository _messageRepo;
  late final GetMessages _getMessages;

  void initializeUseCases() {
    //--------------------------------------------------------------------------
    // Initialize Repositories
    //--------------------------------------------------------------------------
    final authService = AuthServiceImpl();
    _authRepo = AuthRepositoryImp(authService: authService);

    final userService = UserServiceImpl();
    _userRepo = UserRepositoryImp(userService: userService);
    final messageService = MessageServiceImpl();
    _messageRepo = MessageRepositoryImp(messageService: messageService);

    //--------------------------------------------------------------------------
    // Initialize Use Cases
    //--------------------------------------------------------------------------
    _login = Login(repository: _authRepo);
    _register = Register(repository: _authRepo);
    _addUserToDB = AddUserToDB(repository: _userRepo);
    _getUsers = GetUsers(repository: _userRepo);
    _getMessages = GetMessages(repository: _messageRepo);
  }

  @override
  void initState() {
    initializeUseCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthRepositoryImp>.value(value: _authRepo),
            RepositoryProvider<UserRepositoryImp>.value(value: _userRepo),
            RepositoryProvider<Login>.value(value: _login),
            RepositoryProvider<Register>.value(value: _register),
            RepositoryProvider<AddUserToDB>.value(value: _addUserToDB),
            RepositoryProvider<GetUsers>.value(value: _getUsers),
          ],
          child: BlocProvider(
            create: (context) => AppManagerCubit()..init(),
            child: MaterialApp(
              theme: MozzThemeData.theme,
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AppManagerCubit, AppManagerState>(
                builder: (context, state) {
                  if (state.status == AppManagerStatus.done) {
                    return state.isAuthorized
                        ? const ChatListPage()
                        : const LoginPage();
                  } else {
                    return const Scaffold();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
