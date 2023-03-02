import 'package:flutter/material.dart';

import 'styles/theme_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: LightThemeColors.pageBgColor,
  appBarTheme: const AppBarTheme(
    color: LightThemeColors.pageBgColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightThemeColors.pageBgColor,
  ),
  cardTheme: const CardTheme(color: LightThemeColors.pageBgColor, elevation: 0),
  colorScheme: const ColorScheme.light(
    primary: LightThemeColors.pageBgColor,
    secondary: LightThemeColors.pageBgColor,
  ),

  snackBarTheme: const SnackBarThemeData(
      backgroundColor: LightThemeColors.pageBgColor,
      actionTextColor: LightThemeColors.textColor),
  iconTheme: const IconThemeData(
    color: LightThemeColors.textColor,
    size: 24,
    weight: 1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  )),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(
        color: DarkThemeColors.textColor,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  //popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
  buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary),
  //unselectedWidgetColor: _lightPrimaryColor,
  timePickerTheme: const TimePickerThemeData(
      //backgroundColor: kPrimaryColor,
      ),
);
