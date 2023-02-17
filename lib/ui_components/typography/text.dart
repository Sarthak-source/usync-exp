import 'package:flutter/cupertino.dart';

enum UsyncTextType { title3Regular, subHeadlineBold, subHeadlineRegular }

class UsyncText extends StatelessWidget {
  const UsyncText(this.label, {super.key, required this.type, this.padding});

  final String label;

  final EdgeInsets? padding;

  final UsyncTextType type;

  static const Map textStylesMap = {
    UsyncTextType.title3Regular:
        TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
    UsyncTextType.subHeadlineBold: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        leadingDistribution: TextLeadingDistribution.even),
    UsyncTextType.subHeadlineRegular: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        leadingDistribution: TextLeadingDistribution.even)
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Text(
        label,
        style: textStylesMap[type],
      ),
    );
  }
}
