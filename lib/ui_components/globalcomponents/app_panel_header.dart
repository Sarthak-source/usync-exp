import 'package:flutter/material.dart';
import 'package:usync/ui_components/usync_text_field.dart';

class AppPanelHeader extends StatefulWidget {
  final double toolbarHeight;
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
    required this.toolbarHeight,
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
  final _searchController = TextEditingController();

  search() {
    return IconButton(
      // padding: const EdgeInsets.only(left: 30),
      constraints: const BoxConstraints.expand(width: 80),
      icon: action,
      onPressed: () {
        debugPrint('SEARCH');
        setState(
          () {
            if (appBarTitle == widget.child) {
              action = const Text(
                'cancel',
              );
              appBarTitle = UsyncTextField(
                placeholderString: "search",
                onChanged: widget.onSearchInput,
                textController: _searchController,
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
      widget.search == true ? search() : Container(),
    ].followedBy(followedAction).toList();

    return AppBar(
      toolbarHeight: widget.toolbarHeight,
      elevation: 1,
      leading: backstate == true
          ? IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              onPressed: widget.onBackClick,
            )
          : null,
      leadingWidth: 35,
      title: appBarTitle,
      centerTitle: widget.alignment,
      bottom: widget.bottomWidget,
      actions: actionItems,
    );
  }
}
