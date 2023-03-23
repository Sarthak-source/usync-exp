import 'package:flutter/material.dart';

PreferredSizeWidget buildPreferredSizeWidget(Widget child, double preferredHeight) {
  return _PreferredSizeWidget(preferredHeight: preferredHeight, child: child);
}

class _PreferredSizeWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double preferredHeight;

  const _PreferredSizeWidget({
    Key? key,
    required this.child,
    required this.preferredHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredHeight,
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}