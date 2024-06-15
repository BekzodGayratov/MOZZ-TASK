import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/chat_content_painter.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChatPageView();
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------

class _ChatPageView extends StatelessWidget {
  const _ChatPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: kToolbarHeight + 30.h,
          centerTitle: false,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(radius: 34.r),
            title: const Text('Viktor'),
            subtitle: const Text('B seti'),
          )),
      body: const _ChatPageContent(),
    );
  }
}

//------------------------------------------------------------------------------
// CONTENT
//------------------------------------------------------------------------------

class _ChatPageContent extends StatelessWidget {
  const _ChatPageContent();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _mockMessages.length,
        itemBuilder: (context, index) {
          final item = _mockMessages[index];
          return _ChatItem(
              hasItBeenSeen: item['has_been_seen'],
              index: index,
              isThisMyMessage: item['is_mine'],
              text: item['text'],
              date: item['date']);
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
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: 10.h),
      // color: Colors.red,
      child: CustomPaint(
        painter: ChatBubblePainter(isSentByMe: isThisMyMessage),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(text)),
                Gap(10.w),
                Row(
                  children: [
                    Text(DateFormat(DateFormat.HOUR24_MINUTE).format(date)),
                    Gap(5.w),
                    isThisMyMessage
                        ? Visibility(
                            visible: hasItBeenSeen,
                            replacement: MozzSvgPictureLoader.loadAsset(
                                'check'.loadSvgFromName()),
                            child: MozzSvgPictureLoader.loadAsset(
                                'double_check'.loadSvgFromName()))
                        : const SizedBox.shrink()
                  ],
                )
              ],
            )),
      ),
    );
  }
}

List<Map<String, dynamic>> _mockMessages = [
  {
    'text': 'Hello',
    'date': DateTime.now(),
    'is_mine': true,
    'has_been_seen': true
  },
  {
    'text':
        'Mellasdlkjasldjalskdjlkajsdlkjaslkdjqlksjdlqwkjelkqwjdlkjqhwdlqbwdkljqhwdgljqhwdjkqwhdlqjwhdiqwdow',
    'date': DateTime.now(),
    'is_mine': false,
    'has_been_seen': false
  },
  {
    'text': 'Mellow',
    'date': DateTime.now(),
    'is_mine': false,
    'has_been_seen': false
  },
  {
    'text':
        'Mellasdlkjasldjalskdjlkajsdlkjaslkdjqlksjdlqwkjelkqwjdlkjqhwdlqbwdkljqhwdgljqhwdjkqwhdlqjwhdiqwdow',
    'date': DateTime.now(),
    'is_mine': true,
    'has_been_seen': false
  },
];
