import 'package:flutter/material.dart';

import 'styles/theme_colors.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: DarkThemeColors.pageBgColor,
  appBarTheme: const AppBarTheme(
    color: DarkThemeColors.pageBgColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkThemeColors.pageBgColor,
  ),
  cardTheme: const CardTheme(color: DarkThemeColors.pageBgColor, elevation: 0),
  colorScheme: const ColorScheme.dark(
    primary: DarkThemeColors.pageBgColor,
    secondary: DarkThemeColors.pageBgColor,
  ),
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: DarkThemeColors.pageBgColor,
      actionTextColor: DarkThemeColors.textColor),
  iconTheme: const IconThemeData(
    color: DarkThemeColors.textColor,
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
      //primary: kPrimaryColor,
      textStyle: const TextStyle(
        color: LightThemeColors.textColor,
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
