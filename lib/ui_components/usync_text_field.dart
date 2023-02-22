import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usync/utils/theme_color.dart';

class UsyncTextField extends StatefulWidget {
  final TextEditingController textController = TextEditingController();
  Widget prifix;
  final String placeholderString;
  final Function(String)? onChanged;
  UsyncTextField(
      {super.key,
      required this.placeholderString,
      this.onChanged,
      this.prifix = const SizedBox.shrink()});

  @override
  State<UsyncTextField> createState() => _UsyncTextFieldState();
}

class _UsyncTextFieldState extends State<UsyncTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      prefix: widget.prifix,
      controller: widget.textController,
      placeholder: widget.placeholderString,
      decoration: BoxDecoration(
        color: ThemeColor().themecolor(
          context,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          color: ThemeColor().textThemecolor(
            context,
          ),
        ),
      ),
      keyboardType: TextInputType.multiline,
      onChanged: widget.onChanged,
      textCapitalization: TextCapitalization.sentences,
      minLines: 1,
      maxLines: 3,
    );
  }
}
