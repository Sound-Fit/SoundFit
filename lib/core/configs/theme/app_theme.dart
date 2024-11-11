import 'package:flutter/material.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'LexendGiga',
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(color: AppColors.black, fontSize: 25, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
    ), 
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}