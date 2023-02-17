import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPanelHeader extends StatefulWidget {
  final bool back;
  final void Function()? onBackClick;
  final Widget child;
  final bool alignment;
  final PreferredSizeWidget? bottomWidget;
  final List<Widget> actionButtons;
  final bool search;
  final void Function(String)? onSearchInput;
  final void Function()? onSearchCancel;
  const AppPanelHeader({
    super.key,
    this.back = true,
    this.onBackClick,
    required this.child,
    this.bottomWidget,
    this.alignment = false,
    this.search = false,
    this.onSearchInput,
    this.onSearchCancel,
    required this.actionButtons,
  });

  @override
  State<AppPanelHeader> createState() => _AppPanelHeaderState();
}

class _AppPanelHeaderState extends State<AppPanelHeader> {
  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = widget.child;
    Widget action = const Icon(Icons.search);
    final List<Widget> actionItems = <Widget>[
      widget.search == true
          ? IconButton(
              icon: action,
              onPressed: () {
                setState(
                  () {
                    if (action == const Icon(Icons.search)) {
                      action = TextButton(
                        onPressed: widget.onSearchCancel,
                        child: const Text('close'),
                      );
                      appBarTitle = CupertinoTextField(
                        onChanged: widget.onSearchInput,
                      );
                    } else {
                      action = const Icon(Icons.search);
                      appBarTitle = widget.child;
                    }
                  },
                );
              },
            )
          : const SizedBox.shrink(),
    ].followedBy(widget.actionButtons).toList();

    return AppBar(
      toolbarHeight: 70.0,
      elevation: 1,
      leading: widget.back == true
          ? Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: widget.onBackClick,
              ),
            )
          : const SizedBox.shrink(),
      leadingWidth: 30,
      title: appBarTitle,
      centerTitle: widget.alignment,
      bottom: widget.bottomWidget,
      actions: actionItems,
    );
  }
}
