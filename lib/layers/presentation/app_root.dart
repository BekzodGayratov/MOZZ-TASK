import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozz_task/layers/presentation/pages/auth/login/view/login_page.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_list_page.dart';
import 'package:mozz_task/layers/presentation/style/theme.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return  MaterialApp(
          theme: MozzThemeData.theme,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
        );
      },
    );
  }
}
