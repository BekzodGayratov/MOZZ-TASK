import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Чаты"),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: StandartPadding(child: TextFormField(
            decoration: InputDecoration(
              // prefixIcon: MozzSvgPictureLoader.loadAsset('search'.)
            ),
          )),
        ),
      ),
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
    return const Placeholder();
  }
}
