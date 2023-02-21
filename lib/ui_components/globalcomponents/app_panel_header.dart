import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/typography/text.dart';

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
  late Widget appBarTitle = widget.child;
  Widget action = const Icon(Icons.search);
  late List<Widget> folllowedAction = widget.actionButtons;
  late bool backstate = widget.back;
  @override
  Widget build(BuildContext context) {
    final List<Widget> actionItems = <Widget>[
      widget.search == true
          ? IconButton(
              icon: action,
              onPressed: () {
                debugPrint('SEARCH');
                setState(
                  () {
                    if (appBarTitle == widget.child) {
                      action = TextButton(
                        onPressed: widget.onSearchCancel,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Text(
                            'close',
                            style: const TextTheme().title3(
                                context, FontWeight.normal, FontStyle.normal),
                          ),
                        ),
                      );
                      appBarTitle = CupertinoTextField(
                        onChanged: widget.onSearchInput,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(0, 160, 160, 160)),
                      );
                      folllowedAction = [];
                      backstate = false;
                      debugPrint(backstate.toString());
                    } else {
                      action = const Icon(Icons.search);
                      appBarTitle = widget.child;
                      folllowedAction = widget.actionButtons;
                      backstate = widget.back;
                      debugPrint(backstate.toString());
                    }
                  },
                );
              },
            )
          : const SizedBox.shrink(),
    ].followedBy(folllowedAction).toList();

    return AppBar(
      toolbarHeight: 70.0,
      elevation: 1,
      leading: backstate == true
          ? Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: IconButton(
                icon: const FaIcon(
                  Icons.arrow_back_ios,
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
