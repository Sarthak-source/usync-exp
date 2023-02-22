import 'package:flutter/material.dart';
import 'package:usync/utils/theme_color.dart';

class AppPanelSection extends StatefulWidget {
  final Widget title;
  final List<Widget> body;
  final double gutter;
  final CrossAxisAlignment alignment;
  final Axis direction;
  final bool fullwidth;
  final double height;
  const AppPanelSection({
    super.key,
    this.title = const SizedBox.shrink(),
    required this.body,
    required this.gutter,
    this.alignment = CrossAxisAlignment.start,
    required this.direction,
    this.fullwidth = false,
    required this.height,
  });

  @override
  State<AppPanelSection> createState() => _AppPanelSectionState();
}

class _AppPanelSectionState extends State<AppPanelSection> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> bodyItems = widget.body;

    return Container(
      color: ThemeColor().bgThemecolor(context),
      height: MediaQuery.of(context).size.height / widget.height,
      width: widget.fullwidth ? double.infinity : null,
      child: Column(
        crossAxisAlignment: widget.alignment,
        children: [
          widget.title,
          Expanded(
            child: Wrap(
              spacing: widget.gutter,
              direction: widget.direction,
              children: bodyItems,
            ),
          ),
        ],
      ),
    );
  }
}
