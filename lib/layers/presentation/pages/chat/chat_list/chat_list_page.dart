import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mozz_task/layers/domain/usecaces/user/get_users.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/debouncer.dart';
import 'package:mozz_task/layers/presentation/helpers/navigator.dart';
import 'package:mozz_task/layers/presentation/helpers/random_color.dart';
import 'package:mozz_task/layers/presentation/pages/auth/login/view/login_page.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat/chat_page.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_list/cubit/chat_list_page_cubit.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';
import 'package:mozz_task/layers/presentation/widgets/loading_widget.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatListPageCubit(getUsers: context.read<GetUsers>())..getUsers(),
      child: const _ChatListPageView(),
    );
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------

class _ChatListPageView extends StatefulWidget {
  const _ChatListPageView();

  @override
  State<_ChatListPageView> createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<_ChatListPageView> {
  late final FocusNode _searchFieldFocusedNode;
  late final TextEditingController _searchFieldController;

  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  @override
  void initState() {
    _searchFieldFocusedNode = FocusNode();
    _searchFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldFocusedNode.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ChatListPageCubit, ChatListPageState>(
      builder: (context, state) {
        final status = context.select((ChatListPageCubit c) => c.state.status);
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              centerTitle: false,
              title: const Text('Чаты'),
              actions: [
                IconButton(
                    onPressed: () => UserData.signOut().then((value) =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false)),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ))
              ],
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: StandartPadding(
                    child: TextFormField(
                  controller: _searchFieldController,
                  focusNode: _searchFieldFocusedNode,
                  decoration: InputDecoration(
                      hintText: 'Поиск',
                      prefixIcon: MozzSvgPictureLoader.loadAsset(
                          'search'.loadSvgFromName(),
                          color: theme.inputDecorationTheme.prefixIconColor,
                          fit: BoxFit.scaleDown)),
                  onChanged: (v) {
                    _debouncer.run(() {
                      context.read<ChatListPageCubit>().searchUsers(email: v);
                    });
                  },
                )),
              ),
            ),
            body: Builder(builder: (context) {
              if (status == ChatListPageStatus.initial ||
                  status == ChatListPageStatus.loading) {
                return const Center(child: LoadingWidget());
              } else if (status == ChatListPageStatus.failure) {
                return Center(child: Text(state.failureMessage.toString()));
              }

              return _ChatListPageContent(
                  searchFieldFocusedNode: _searchFieldFocusedNode);
            }));
      },
    );
  }
}

//------------------------------------------------------------------------------
// CONTENT
//------------------------------------------------------------------------------

class _ChatListPageContent extends StatelessWidget {
  final FocusNode searchFieldFocusedNode;
  const _ChatListPageContent({required this.searchFieldFocusedNode});

  @override
  Widget build(BuildContext context) {
    final users = context
        .select((ChatListPageCubit c) => c.state.users)
        .where((element) => element.email != UserData.user.email)
        .toList();
    if (users.isEmpty) {
      return const Center(
        child: Text('Пользователи не существуют'),
      );
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final item = users[index];
          return Column(
            children: [
              const Divider(),
              ListTile(
                onTap: () {
                  searchFieldFocusedNode.unfocus();
                  navigateToPage(context, ChatPage(user: item));
                },
                leading: CircleAvatar(
                  radius: 34.r,
                  backgroundColor: getRandomColor(),
                  child: Text(item.email![0].toUpperCase(),style: TextStyle(fontSize: 20.sp,color: Colors.white)),
                ),
                title: Text(item.email.toString()).animate().fade().scale(),
                subtitle: const Text('Я готов').animate().fade().scale(),
                trailing: Text(
                    DateFormat(DateFormat.WEEKDAY).format(item.created_at!)),
              ),
            ],
          );
        });
  }
}
