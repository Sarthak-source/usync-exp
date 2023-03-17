import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    super.key,
    this.size = 50.0,
    this.border = 0.0,
    this.borderColor,
    this.padding,
    required this.imageUrl,
  });

  final double? size;

  final double? border;

  final Color? borderColor;

  final EdgeInsets? padding;
  final List<String> imageUrl;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    double? radius() {
      if (widget.imageUrl.length != 1) {
        return (widget.size)! / 1.5;
      } else {
        return (widget.size);
      }
    }

    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Container(
        width: widget.size! * 2,
        height: 5 + (widget.size! * 2),
        decoration: widget.border! > 0.0
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.borderColor!,
                  width: widget.border!,
                ),
              )
            : null,
        child: SizedBox(
          height: 50,
          width: 75,
          child: Stack(
            children: [
              for (var i = 0; i < widget.imageUrl.length.clamp(0, 3); i++)
                Positioned(
                  left: (i * (1 - .4) * 15).toDouble() + 1,
                  top: i.toDouble(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.imageUrl[i],
                    ),
                    radius: radius(),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(5.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
