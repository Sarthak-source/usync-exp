import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usync/utils/theme_color.dart';

import 'config/customtext/customtext.dart';

class UsyncTextField extends StatefulWidget {
  final TextEditingController textController;
  final Widget prifix;
  final Widget suffix;
  final TextInputType keyboardType;
  final String placeholderString;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool border;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final double height;
  final Function(String)? onSubmitted;

  const UsyncTextField(
      {super.key,
      required this.textController,
      this.placeholderString = '',
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.prifix = const SizedBox.shrink(),
      this.suffix = const SizedBox.shrink(),
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.border = true,
      this.height = 40,
      this.onTap,
      this.onSubmitted,
      this.onEditingComplete});

  @override
  State<UsyncTextField> createState() => _UsyncTextFieldState();
}

class _UsyncTextFieldState extends State<UsyncTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CupertinoTextField(
        prefix: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: widget.prifix,
        ),
        suffix: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: widget.suffix,
        ),
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        controller: widget.textController,
        onEditingComplete: widget.onEditingComplete,
        placeholder: widget.placeholderString,
        style: const TextTheme()
            .body(context, FontWeight.normal, FontStyle.normal),
        decoration: BoxDecoration(
            color: ThemeColor().themeTextFieldColor(context),
            borderRadius: BorderRadius.circular(10),
            border: widget.border == true
                ? Border.all(color: ThemeColor().textThemecolor(context))
                : null),
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        textCapitalization: TextCapitalization.sentences,
        minLines: 1,
        maxLines: 3,
      ),
    );
  }
}
