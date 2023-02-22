import 'package:flutter/cupertino.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';

List<Widget> subpaneldetails = [
  const AppPanelHeader(
    actionButtons: [],
    child: Text('details'),
  ),
  const AppPanelSection(
    body: [],
    direction: Axis.vertical,
    gutter: 10,
  ),
];
