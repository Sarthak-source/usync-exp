import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';

class ThemeColor {
  Color themecolor(BuildContext context) {
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.dark) {
      return DarkThemeColors.textColor;
    } else {
      return LightThemeColors.secondaryDark;
    }
  }

  Color textThemecolor(BuildContext context) {
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.dark) {
      return LightThemeColors.secondaryDark;
    } else {
      return DarkThemeColors.textColor;
    }
  }

  Color bgThemecolor(BuildContext context) {
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.dark) {
      return LightThemeColors.pageBgColor;
    } else {
      return DarkThemeColors.pageBgColor;
    }
  }
}
