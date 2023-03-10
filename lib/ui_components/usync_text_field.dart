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
  final Function(String)? onChanged;

  const UsyncTextField({
    super.key,
    required this.textController,
    required this.placeholderString,
    this.keyboardType = TextInputType.none,
    this.onChanged,
    this.prifix = const SizedBox.shrink(),
    this.suffix = const SizedBox.shrink(),
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  @override
  State<UsyncTextField> createState() => _UsyncTextFieldState();
}

class _UsyncTextFieldState extends State<UsyncTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      prefix: widget.prifix,
      suffix: widget.suffix,
      controller: widget.textController,
      placeholder: widget.placeholderString,
      style:
          const TextTheme().body(context, FontWeight.normal, FontStyle.normal),
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
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      textCapitalization: TextCapitalization.sentences,
      minLines: 1,
      maxLines: 3,
    );
  }
}
