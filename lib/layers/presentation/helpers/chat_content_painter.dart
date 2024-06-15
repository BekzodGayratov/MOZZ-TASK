import 'package:flutter/material.dart';

class ChatBubblePainter extends CustomPainter {
  final bool isSentByMe;

  ChatBubblePainter({required this.isSentByMe});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSentByMe ? const Color(0xff3CED78) : const Color(0xffEDF2F6)
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isSentByMe) {
      path.moveTo(size.width - 10, 0);
      path.lineTo(10, 0);
      path.quadraticBezierTo(0, 0, 0, 10);
      path.lineTo(0, size.height - 10);
      path.quadraticBezierTo(0, size.height, 10, size.height);
      path.lineTo(size.width - 10, size.height);
      path.quadraticBezierTo(
          size.width, size.height, size.width, size.height - 10);
      path.lineTo(size.width, 10);
      path.quadraticBezierTo(size.width, 0, size.width - 10, 0);
    } else {
      path.moveTo(10, 0);
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(
          size.width, size.height, size.width - 10, size.height);
      path.lineTo(10, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - 10);
      path.lineTo(0, 10);
      path.quadraticBezierTo(0, 0, 10, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
