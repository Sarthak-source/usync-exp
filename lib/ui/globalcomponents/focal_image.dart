import 'package:flutter/cupertino.dart';

enum FocalImageRadius { xs, sm, md, lg, xl }

class FocalImage extends StatelessWidget {
  const FocalImage(
      {super.key,
      required this.imagelink,
      this.ratio = 1,
      this.focus = const {"x": 50, "y": 50},
      this.radiusType = FocalImageRadius.md});
  final String imagelink;
  final double ratio;
  final Map<String, double> focus;
  final FocalImageRadius radiusType;
  static Map<FocalImageRadius, BorderRadius> radiusMap = {
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
          borderRadius: radiusMap[radiusType],
          image: DecorationImage(
            image: NetworkImage(imagelink),
            fit: BoxFit.cover,
            alignment: FractionalOffset(focus["x"]! / 100, focus["y"]! / 100),
          ),
        ),
      ),
    );
  }
}
