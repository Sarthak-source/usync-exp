import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/typography/text.dart';
import 'package:usync/ui_components/usync_text_field.dart';

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
  late List<Widget> followedAction = widget.actionButtons;
  late bool backstate = widget.back;

  search() {
    return IconButton(
      icon: action,
      onPressed: () {
        debugPrint('SEARCH');
        setState(
          () {
            if (appBarTitle == widget.child) {
              action = IconButton(
                constraints: const BoxConstraints.expand(width: 30),
                onPressed: widget.onSearchCancel,
                icon: const Text('cancel'),
              );

              appBarTitle = Padding(
                padding: const EdgeInsets.only(right: 20),
                child: UsyncTextField(
                  placeholderString: "search",
                  onChanged: widget.onSearchInput,
                ),
              );
              followedAction = [];
              backstate = false;
              debugPrint(backstate.toString());
            } else {
              action = const Icon(Icons.search);
              appBarTitle = widget.child;
              followedAction = widget.actionButtons;
              backstate = widget.back;
              debugPrint(backstate.toString());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionItems = <Widget>[
      widget.search == true ? search() : const SizedBox.shrink(),
    ].followedBy(followedAction).toList();

    return AppBar(
      toolbarHeight: 80.0,
      elevation: 1,
      leading: backstate == true
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    widget.onBackClick;
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : null,

      //leadingWidth: 30,

      title: appBarTitle,
      centerTitle: widget.alignment,
      bottom: widget.bottomWidget,
      actions: actionItems,
    );
  }
}
