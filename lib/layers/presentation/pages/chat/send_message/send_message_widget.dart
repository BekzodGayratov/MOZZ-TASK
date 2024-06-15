import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozz_task/layers/domain/entity/message.dart';
import 'package:mozz_task/layers/domain/usecaces/message/send_message.dart';
import 'package:mozz_task/layers/presentation/pages/chat/send_message/cubit/send_message_cubit.dart';
import 'package:mozz_task/layers/presentation/singletions.dart';

//------------------------------------------------------------------------------
// SEND MESSAGE WIDGET
//------------------------------------------------------------------------------
class SendMessageWidget extends StatelessWidget {
  final String receiverId;
  const SendMessageWidget({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SendMessageCubit(sendMessage: context.read<SendMessage>()),
        child: _MessageControllerView(receiverId: receiverId));
  }
}

//------------------------------------------------------------------------------
// MESSAGE CONTROLLEr
//------------------------------------------------------------------------------
class _MessageControllerView extends StatefulWidget {
  final String receiverId;
  const _MessageControllerView({required this.receiverId});

  @override
  State<_MessageControllerView> createState() => _MessageControllerViewState();
}

class _MessageControllerViewState extends State<_MessageControllerView> {
  late final TextEditingController _messageEditingController;

  late final FocusNode _focusNode;

  @override
  void initState() {
    _messageEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _messageEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file_rounded)),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: _messageEditingController,
                  decoration: const InputDecoration(hintText: 'Сообщение'),
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
              )),
              Visibility(
                visible: _messageEditingController.text.isEmpty,
                replacement: IconButton(
                    onPressed: () {
                      context.read<SendMessageCubit>().sendMessage(
                          message: Message(
                              receiver_id: widget.receiverId,
                              sender_id: UserData.user.email,
                              created_at: DateTime.now(),
                              text: _messageEditingController.text));

                      _messageEditingController.clear();
                      _focusNode.unfocus();
                    },
                    icon: const Icon(Icons.send_outlined)),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.mic_outlined)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
