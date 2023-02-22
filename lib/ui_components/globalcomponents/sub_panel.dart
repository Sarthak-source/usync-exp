import 'package:flutter/material.dart';

class SubPanel {
  showSubPanel(context, List<Widget> body, double adjustHeight) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / adjustHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: body,
          ),
        );
      },
    );
  }
}
