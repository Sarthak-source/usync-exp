import 'package:flutter/cupertino.dart';
import 'package:flutter_module/config/theme_colors.dart';

class QIcon extends StatelessWidget {
  const QIcon(this.icon,
      {super.key,
      this.color,
      this.size = 30,
      this.filled = false,
      this.filledColor,
      this.padding,
      this.onPressed});

  final IconData icon;

  final Color? color;

  final Color? filledColor;

  final double? size;

  final bool? filled;

  final EdgeInsets? padding;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: filled!
          ? BoxDecoration(
              color: filledColor!,
              borderRadius: const BorderRadius.all(Radius.circular(50)))
          : null,
      child: CupertinoButton(
        padding: padding ?? const EdgeInsets.all(18),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: filled! ? ThemeColors.pageBgColor : color,
          size: size,
        ),
      ),
    );
  }
}
