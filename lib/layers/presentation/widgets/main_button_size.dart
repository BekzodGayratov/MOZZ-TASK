import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButtonSize extends StatelessWidget {
  final Widget child;
  const MainButtonSize({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: child,
    );
  }
}
