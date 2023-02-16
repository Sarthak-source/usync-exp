import 'package:flutter/material.dart';

class AppPanel extends StatefulWidget {
  final double radius;
  final Widget body;
  const AppPanel({super.key, this.radius = 16, required this.body});
  @override
  State<AppPanel> createState() => _AppPanelState();
}

class _AppPanelState extends State<AppPanel> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Scaffold(
        body: widget.body,
      ),
    );
  }
}
