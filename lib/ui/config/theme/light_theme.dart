import 'package:flutter/material.dart';

import 'styles/theme_colors.dart';

TextStyle _textStyle(BuildContext context, double size, Color color) {
  return TextStyle(
    fontSize: size,
    color: color,
    letterSpacing: 0,
  );
}

TextTheme lightTextTheme(BuildContext context) {
  return const TextTheme().copyWith(
    //bodyText1: TextStyle(fontSize: 18, color: kSecondaryDarkTextColor),
    bodyText1: _textStyle(context, 18, LightThemeColors.textColor),
    //bodyText2: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    bodyText2: _textStyle(context, 16, LightThemeColors.textColor),
    // button: TextStyle(
    //     fontSize: 16,
    //     color: kPrimaryLightTextColor,
    //     fontWeight: FontWeight.bold),
    button: _textStyle(context, 16, LightThemeColors.textColor),

    // headline6: TextStyle(fontSize: 18, color: LightThemeColors.textColor),
    headline6: _textStyle(context, 18, LightThemeColors.textColor),
    //headline5: TextStyle(fontSize: 24, color: LightThemeColors.textColor),
    headline5: _textStyle(context, 24, LightThemeColors.textColor),
    //headline4: TextStyle(fontSize: 34, color: LightThemeColors.textColor),
    headline4: _textStyle(context, 34, LightThemeColors.textColor),
    //headline3: TextStyle(fontSize: 44, color: LightThemeColors.textColor),
    headline3: _textStyle(context, 44, LightThemeColors.textColor),
    //headline2: TextStyle(fontSize: 54, color: LightThemeColors.textColor),
    headline2: _textStyle(context, 54, LightThemeColors.textColor),
    //headline1: TextStyle(fontSize: 64, color: LightThemeColors.textColor),
    headline1: _textStyle(context, 64, LightThemeColors.textColor),
    //subtitle1: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    subtitle1: _textStyle(context, 16, LightThemeColors.textColor),
    // subtitle2: TextStyle(fontSize: 14.0, color: kSecondaryDarkTextColor),
    subtitle2: _textStyle(context, 14.0, LightThemeColors.textColor),
    //caption: TextStyle(fontSize: 12.0, color: kSecondaryDarkTextColor),
    caption: _textStyle(context, 12.0, LightThemeColors.textColor),

    // overline: TextStyle(
    //     fontSize: 10.0, color: kSecondaryDarkTextColor, letterSpacing: 0),
    overline: _textStyle(context, 10.0, LightThemeColors.textColor),
  );
}

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
  // switchTheme: SwitchThemeData(
  //   overlayColor: MaterialStateProperty.all(kPrimaryColor),
  // ),
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: LightThemeColors.pageBgColor,
      actionTextColor: LightThemeColors.textColor),
  iconTheme: const IconThemeData(
      //color: kDarkColor,
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    //primary: kPrimaryColor,
    //onPrimary: kLightColor,
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
  timePickerTheme: TimePickerThemeData(
      //backgroundColor: kPrimaryColor,
      ),
);
