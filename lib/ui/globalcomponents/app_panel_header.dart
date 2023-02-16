import 'package:flutter/material.dart';

class AppPanelHeader extends StatefulWidget {
  final Widget title;
  final List<Widget> actionButtons;
  const AppPanelHeader(
      {super.key, required this.title, required this.actionButtons});

  @override
  State<AppPanelHeader> createState() => _AppPanelHeaderState();
}

class _AppPanelHeaderState extends State<AppPanelHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.0,
      elevation: 1,
      leading: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.grey,
        ),
      ),
      leadingWidth: 30,
      title: widget.title,
      actions: widget.actionButtons,
    );
  }
}
