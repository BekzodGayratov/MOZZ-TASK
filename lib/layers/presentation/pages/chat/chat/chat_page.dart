import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/message/edit_message.dart';
import 'package:mozz_task/layers/domain/usecaces/message/get_messages.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat/cubit/chat_page_cubit.dart';
import 'package:mozz_task/layers/presentation/pages/chat/send_message/send_message_widget.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';
import 'package:mozz_task/layers/presentation/widgets/loading_widget.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class ChatPage extends StatelessWidget {
  final User user;
  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatPageCubit(
          getMessages: context.read<GetMessages>(),
          editMessage: context.read<EditMessage>())
        ..getUsers(senderId: UserData.user.email, receiverId: user.email),
      child: _ChatPageView(user: user),
    );
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------

class _ChatPageView extends StatefulWidget {
  final User user;
  const _ChatPageView({required this.user});

  @override
  State<_ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<_ChatPageView> {
  late final TextEditingController _messageEditingController;

  @override
  void initState() {
    _messageEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final states = context.select((ChatPageCubit c) => c.state);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            toolbarHeight: kToolbarHeight + 30.h,
            centerTitle: false,
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(radius: 34.r),
              title: Text(widget.user.email.toString()),
              subtitle: const Text('B seti'),
            )),
        body: Builder(builder: (context) {
          if (states.status == ChatPageStatus.initial ||
              states.status == ChatPageStatus.loading) {
            return const Center(child: LoadingWidget());
          } else if (states.status == ChatPageStatus.failure) {
            return Center(child: Text(states.failureMessage.toString()));
          }
          return const _ChatPageContent();
        }).animate().fadeIn().scale(),
        bottomSheet: SendMessageWidget(receiverId: widget.user.email!));
  }
}

//------------------------------------------------------------------------------
// CONTENT
//------------------------------------------------------------------------------

class _ChatPageContent extends StatelessWidget {
  const _ChatPageContent();

  @override
  Widget build(BuildContext context) {
    final stream = context.select((ChatPageCubit c) => c.state.messages);
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final messages = snapshot.data;
            if (messages!.isEmpty) {
              return const Center(child: Text('No messages available'));
            }

            return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final item = messages[index];

                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == messages.length - 1 ? 140.h : 0.0),
                    child: _ChatItem(
                        isThisMyMessage: item.sender_id == UserData.user.email,
                        text: item.text.toString(),
                        date: item.created_at!,
                        index: index,
                        hasItBeenSeen: true),
                  );
                });
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

//------------------------------------------------------------------------------
// CHAT ITEM
//------------------------------------------------------------------------------

class _ChatItem extends StatelessWidget {
  final String text;
  final DateTime date;
  final bool isThisMyMessage;
  final bool hasItBeenSeen;
  final int index;
  const _ChatItem(
      {required this.isThisMyMessage,
      required this.text,
      required this.date,
      required this.index,
      required this.hasItBeenSeen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment:
            isThisMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _showActionsDialog(context: context, onTapEdit: () {}),
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                color: isThisMyMessage
                    ? const Color(0xff3CED78)
                    : const Color(0xffEDF2F6),
                borderRadius: _buildCornerOfContent(isThisMyMessage),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(text)),
                          Gap(10.w),
                          Row(
                            children: [
                              Text(DateFormat(DateFormat.HOUR24_MINUTE)
                                  .format(date)),
                              Gap(5.w),
                              isThisMyMessage
                                  ? Visibility(
                                      visible: hasItBeenSeen,
                                      replacement:
                                          MozzSvgPictureLoader.loadAsset(
                                              'check'.loadSvgFromName()),
                                      child: MozzSvgPictureLoader.loadAsset(
                                          'double_check'.loadSvgFromName()))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _showActionsDialog(
      {required BuildContext context, required VoidCallback onTapEdit}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: onTapEdit,
                    leading: Icon(Icons.edit_outlined),
                    title: Text("Edit"),
                  ),
                  Gap(10.h),
                  ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text("Delete"),
                  )
                ],
              ),
            ),
          );
        });
  }

  BorderRadius _buildCornerOfContent(bool isThisMyMessage) {
    if (isThisMyMessage) {
      return BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.zero);
    }

    return BorderRadius.only(
        topLeft: Radius.circular(12.r),
        topRight: Radius.circular(12.r),
        bottomLeft: Radius.zero,
        bottomRight: Radius.circular(12.r));
  }
}
