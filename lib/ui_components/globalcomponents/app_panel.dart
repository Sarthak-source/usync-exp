import 'package:flutter/material.dart';

enum AppPanelRadius { xs, sm, md, lg, xl, none }

class AppPanel extends StatefulWidget {
  const AppPanel(
      {super.key, this.radius = AppPanelRadius.md, required this.content});

  final List<Widget> content;
  final AppPanelRadius radius;
  static Map<AppPanelRadius, BorderRadius> radiusMap = {
    AppPanelRadius.xs: BorderRadius.circular(4.0),
    AppPanelRadius.sm: BorderRadius.circular(8.0),
    AppPanelRadius.md: BorderRadius.circular(12.0),
    AppPanelRadius.lg: BorderRadius.circular(16.0),
    AppPanelRadius.xl: BorderRadius.circular(20.0),
    AppPanelRadius.none: BorderRadius.zero,
  };

  @override
  State<AppPanel> createState() => _AppPanelState();
}

class _AppPanelState extends State<AppPanel> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppPanel.radiusMap[widget.radius],
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.content,
        ),
      ),
    );
  }
}
