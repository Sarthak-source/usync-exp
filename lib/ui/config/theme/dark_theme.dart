import 'package:flutter/material.dart';

import 'styles/theme_colors.dart';

TextStyle _textStyle(BuildContext context, double size, Color color) {
  return TextStyle(
    fontSize: size,
    color: color,
    letterSpacing: 0,
  );
}

TextTheme darkTextTheme(BuildContext context) {
  return const TextTheme().copyWith(
    //bodyText1: TextStyle(fontSize: 18, color: kSecondaryDarkTextColor),
    bodyText1: _textStyle(context, 18, DarkThemeColors.textColor),
    //bodyText2: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    bodyText2: _textStyle(context, 16, DarkThemeColors.textColor),
    // button: TextStyle(
    //     fontSize: 16,
    //     color: DarkThemeColors.textColor,
    //     fontWeight: FontWeight.bold),
    button: _textStyle(context, 16, DarkThemeColors.textColor),

    // headline6: TextStyle(fontSize: 18, color: kPrimaryDarkTextColor),
    headline6: _textStyle(context, 18, DarkThemeColors.textColor),
    //headline5: TextStyle(fontSize: 24, color: kPrimaryDarkTextColor),
    headline5: _textStyle(context, 24, DarkThemeColors.textColor),
    //headline4: TextStyle(fontSize: 34, color: kPrimaryDarkTextColor),
    headline4: _textStyle(context, 34, DarkThemeColors.textColor),
    //headline3: TextStyle(fontSize: 44, color: kPrimaryDarkTextColor),
    headline3: _textStyle(context, 44, DarkThemeColors.textColor),
    //headline2: TextStyle(fontSize: 54, color: kPrimaryDarkTextColor),
    headline2: _textStyle(context, 54, DarkThemeColors.textColor),
    //headline1: TextStyle(fontSize: 64, color: kPrimaryDarkTextColor),
    headline1: _textStyle(context, 64, DarkThemeColors.textColor),
    //subtitle1: TextStyle(fontSize: 16, color: kSecondaryDarkTextColor),
    subtitle1: _textStyle(context, 16, DarkThemeColors.textColor),
    // subtitle2: TextStyle(fontSize: 14.0, color: kSecondaryDarkTextColor),
    subtitle2: _textStyle(context, 14.0, DarkThemeColors.textColor),
    //caption: TextStyle(fontSize: 12.0, color: kSecondaryDarkTextColor),
    caption: _textStyle(context, 12.0, DarkThemeColors.textColor),

    // overline: TextStyle(
    //     fontSize: 10.0, color: kSecondaryDarkTextColor, letterSpacing: 0),
    overline: _textStyle(context, 10.0, DarkThemeColors.textColor),
  );
}

ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: DarkThemeColors.pageBgColor,
    appBarTheme: const AppBarTheme(
      color: DarkThemeColors.pageBgColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkThemeColors.pageBgColor,
    ),
    cardTheme:
        const CardTheme(color: DarkThemeColors.pageBgColor, elevation: 0),
    colorScheme: const ColorScheme.dark(
      primary: DarkThemeColors.pageBgColor,
      secondary: DarkThemeColors.pageBgColor,
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: DarkThemeColors.pageBgColor,
        actionTextColor: DarkThemeColors.textColor),
    iconTheme: const IconThemeData(
        //color: kLightColor,
        ),
    // switchTheme: SwitchThemeData(
    //   overlayColor: MaterialStateProperty.all(kPrimaryColor),
    //   trackColor: MaterialStateProperty.all(kAccentColor),
    //   thumbColor: MaterialStateProperty.all(kPrimaryColor),
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      // primary: kPrimaryColor,
      // onPrimary: kLightColor,
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
    timePickerTheme: const TimePickerThemeData(
        //backgroundColor: kPrimaryColor,
        ));
