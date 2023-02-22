import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/utils/theme_color.dart';

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

  TextStyle largeTitle(
    BuildContext context,
    FontWeight fontWeight,
    FontStyle fontStyle,
  ) {
    return _textStyle(
      context: context,
      size: 34,
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
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
      color: ThemeColor().textThemecolor(context),
      fontStyle: fontStyle,
      fontWeight: fontWeight,
    );
  }
}
