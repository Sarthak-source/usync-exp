import 'package:flutter/material.dart';

class AppPanelSection extends StatefulWidget {
  final Widget title;
  final List<Widget> body;
  const AppPanelSection(
      {super.key, this.title = const SizedBox.shrink(), required this.body});

  @override
  State<AppPanelSection> createState() => _AppPanelSectionState();
}

class _AppPanelSectionState extends State<AppPanelSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title,
        Column(
          children: widget.body,
        )
      ],
    );
  }
}
