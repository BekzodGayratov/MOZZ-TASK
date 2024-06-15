import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MozzThemeData {
  static final _theme = ThemeData(
      //--------------------------------------------------------------------------
      // APP BAR THEME
      //--------------------------------------------------------------------------

      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 32.sp,
              fontWeight: FontWeight.w600)),

      //--------------------------------------------------------------------------
      // INPUT THEME
      //--------------------------------------------------------------------------

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffEDF2F6),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xff9DB7CB))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.transparent)),
      ));

  // GETTER
  static ThemeData get theme => _theme;
}
