import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mozz_task/layers/domain/usecaces/user/get_users.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/navigator.dart';
import 'package:mozz_task/layers/presentation/helpers/random_color.dart';
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

class _ChatListPageView extends StatelessWidget {
  const _ChatListPageView();

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
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: StandartPadding(
                    child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Поиск',
                      prefixIcon: MozzSvgPictureLoader.loadAsset(
                          'search'.loadSvgFromName(),
                          color: theme.inputDecorationTheme.prefixIconColor,
                          fit: BoxFit.scaleDown)),
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

              return const _ChatListPageContent();
            }));
      },
    );
  }
}

//------------------------------------------------------------------------------
// CONTENT
//------------------------------------------------------------------------------

class _ChatListPageContent extends StatelessWidget {
  const _ChatListPageContent();

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
                onTap: () => navigateToPage(context, const ChatPage()),
                leading: CircleAvatar(
                  radius: 34.r,
                  backgroundColor: getRandomColor(),
                ),
                title: Text(item.email.toString()),
                subtitle: const Text('Я готов'),
                trailing:
                    Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.now())),
              ),
            ],
          );
        });
  }
}
