import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.src,
      this.size = 50.0,
      this.border = 0.0,
      this.borderColor,
      this.padding});

  final String src;

  final double? size;

  final double? border;

  final Color? borderColor;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        width: size! * 2,
        height: size! * 2,
        decoration: border! > 0.0
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor!,
                  width: border!,
                ),
              )
            : null,
        child: CircleAvatar(
          radius: size,
          backgroundImage:
              NetworkImage(src, scale: 2), // TODO: Add fallback handler
        ),
      ),
    );
  }
}
