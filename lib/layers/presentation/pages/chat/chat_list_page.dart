import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/navigator.dart';
import 'package:mozz_task/layers/presentation/helpers/random_color.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_page.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChatListPageView();
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
      body: const _ChatListPageContent(),
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
    return ListView.builder(itemBuilder: (context, index) {
      return Column(
        children: [
          const Divider(),
          ListTile(
            onTap: () => navigateToPage(context, const ChatPage()),
            leading: CircleAvatar(
              radius: 34.r,
              backgroundColor: getRandomColor(),
            ),
            title: const Text('Viktor Orban'),
            subtitle: const Text('Я готов'),
            trailing:
                Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.now())),
          ),
        ],
      );
    });
  }
}
