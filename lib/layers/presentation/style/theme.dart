import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MozzThemeData {
  static final _theme = ThemeData(
//--------------------------------------------------------------------------
// APP BAR THEME
//--------------------------------------------------------------------------

    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 32.sp, fontWeight: FontWeight.w600)),

//--------------------------------------------------------------------------
// INPUT THEME
//--------------------------------------------------------------------------

    inputDecorationTheme: InputDecorationTheme(
      
        filled: true,
        fillColor: const Color(0xffEDF2F6),
        hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff9DB7CB)),
        prefixIconColor: const Color(0xff9DB7CB),
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
            borderSide: const BorderSide(color: Colors.transparent))),

//--------------------------------------------------------------------------
// DIVIDER
//--------------------------------------------------------------------------

    dividerTheme: const DividerThemeData(color: Color(0xffEDF2F6)),
    dividerColor: const Color(0xffEDF2F6),

//--------------------------------------------------------------------------
// BUTTONS THEME
//--------------------------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.black)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3CED78),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)))),
  );

  // GETTER
  static ThemeData get theme => _theme;
}
