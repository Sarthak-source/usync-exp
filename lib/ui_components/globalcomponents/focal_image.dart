import 'package:flutter/cupertino.dart';

/// FocalImageRadius defines the various radius values available for a focal image.
enum FocalImageRadius { none, xs, sm, md, lg, xl }

/// This is an image renderer component based on the ratio and the focus provided to the component.
class FocalImage extends StatelessWidget {
  const FocalImage(
      {super.key,
      required this.src,
      this.ratio = 1,
      this.focus = const {"x": 50, "y": 50},
      this.radius = FocalImageRadius.md});

  /// The source for the image.
  final String src;

  /// The aspect ration for the image
  final double ratio;

  /// The focal point for the image. This value is a map of x,y co-ordinate values as percentage,
  final Map<String, double> focus;

  /// The radius of the focal image.
  final FocalImageRadius radius;

  static Map<FocalImageRadius, BorderRadius> radiusMap = {
    FocalImageRadius.none: BorderRadius.circular(0),
    FocalImageRadius.xs: BorderRadius.circular(4.0),
    FocalImageRadius.sm: BorderRadius.circular(8.0),
    FocalImageRadius.md: BorderRadius.circular(12.0),
    FocalImageRadius.lg: BorderRadius.circular(16.0),
    FocalImageRadius.xl: BorderRadius.circular(20.0),
  };

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radiusMap[radius],
          image: DecorationImage(
            image: NetworkImage(src),
            fit: BoxFit.cover,
            alignment: FractionalOffset(focus["x"]! / 100, focus["y"]! / 100),
          ),
        ),
      ),
    );
  }
}
