import 'package:flutter/material.dart';

class AppPanelSection extends StatefulWidget {
  final Widget title;
  final List<Widget> body;
  final double gutter;
  final CrossAxisAlignment alignment;
  final Axis direction;
  final bool fullwidth;
  const AppPanelSection({
    super.key,
    this.title = const SizedBox.shrink(),
    required this.body,
    required this.gutter,
    this.alignment = CrossAxisAlignment.start,
    required this.direction,
    this.fullwidth = false,
  });

  @override
  State<AppPanelSection> createState() => _AppPanelSectionState();
}

class _AppPanelSectionState extends State<AppPanelSection> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> bodyItems = widget.body;

    return SizedBox(
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
