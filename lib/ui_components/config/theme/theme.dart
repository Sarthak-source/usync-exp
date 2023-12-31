import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/config/theme/dark_theme.dart';
import 'package:usync/ui_components/config/theme/light_theme.dart';

import 'styles/theme_colors.dart';

class AppTheme {
  AppTheme._();

  static light(BuildContext context) {
    return lightTheme.copyWith(
      //textTheme: UsyncTextType(),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: LightThemeColors.subpanel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: LightThemeColors.textColor,
      ),

     

      dividerColor: LightThemeColors.textColor,
      bottomAppBarTheme: const BottomAppBarTheme().copyWith(
        color: LightThemeColors.pageBgColor,
        elevation: 1,
      ),

      

      appBarTheme: const AppBarTheme().copyWith(
        color: LightThemeColors.pageBgColor,
        titleTextStyle: const TextTheme()
            .title3(context, FontWeight.normal, FontStyle.normal),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 64,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  static dark(BuildContext context) {
    return darkTheme.copyWith(
      //textTheme: darkTextTheme(context),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: DarkThemeColors.subpanel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: DarkThemeColors.textColor,
      ),

      bottomAppBarTheme: const BottomAppBarTheme().copyWith(
        color: DarkThemeColors.pageBgColor,
        elevation: 1,
      ),
      dividerColor: DarkThemeColors.textColor,
      appBarTheme: const AppBarTheme().copyWith(
        color: DarkThemeColors.pageBgColor,
        titleTextStyle: const TextTheme()
            .title3(context, FontWeight.normal, FontStyle.normal),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 64,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
