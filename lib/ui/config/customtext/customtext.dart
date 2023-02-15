import 'package:chatsampleapp/ui/config/theme/styles/theme_colors.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

extension UsyncTextType on TextTheme {
  TextStyle _textStyle({
    required BuildContext context,
    required double size,
    required Color color,
    required FontWeight fontWeight,
    required FontStyle fontStyle,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: 0,
    );
  }

  Color _themecolor(BuildContext context) {
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.dark) {
      return DarkThemeColors.textColor;
    } else {
      return LightThemeColors.textColor;
    }
  }

  TextStyle largeTitle(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 34,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle title1(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 28,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle title2(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 22,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle title3(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 20,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle headline(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 17,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle body(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 17,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle callout(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 16,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle subheadline(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 15,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle footnote(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 13,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle caption1(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 12,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }

  TextStyle caption2(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 11,
      color: _themecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }
}
