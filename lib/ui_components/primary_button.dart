import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.onPressed, this.label = '', this.child});

  final String? label;

  final Widget? child;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {

    return CupertinoButton.filled(
      onPressed: onPressed,
      child: child ?? Text(
            label!,
            style: const TextStyle(color: Color(0xffffffff)),
          ),
    );
  }
}
