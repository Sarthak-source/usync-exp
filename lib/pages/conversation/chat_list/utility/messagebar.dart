// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usync/ui_components/usync_text_field.dart';

///Normal Message bar with more actions
///
/// following attributes can be modified
///
///
/// # BOOLEANS
/// [replying] is additional reply widget top of the message bar
///
/// # STRINGS
/// [replyingTo] is a string to tag the replying message
///
/// # WIDGETS
/// [actions] are the additional leading action buttons like camera
/// and file select
///
/// # COLORS
/// [replyWidgetColor] is reply widget color
/// [replyIconColor] is the reply icon color on the left side of reply widget
/// [replyCloseColor] is the close icon color on the right side of the reply
/// widget
/// [messageBarColor] is the color of the message bar
/// [sendButtonColor] is the color of the send button
///
/// # METHODS
/// [onTextChanged] is function which triggers after text every text change
/// [onSend] is send button action
/// [onTapCloseReply] is close button action of the close button on the
/// reply widget usually change [replying] attribute to `false`

class MessageBar extends StatelessWidget {
  final bool replying;
  final String replyingTo;
  final List<Widget> actions;
  final TextEditingController textController;
  final Color replyWidgetColor;
  final Color replyIconColor;
  final Color replyCloseColor;
  final Color messageBarColor;
  final Color sendButtonColor;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSend;
  final void Function()? onTapCloseReply;
  final bool? sendbutton;

  /// [MessageBar] constructor
  ///
  ///
  MessageBar(
      {super.key,
      this.replying = false,
      this.replyingTo = "",
      required this.textController,
      this.actions = const [],
      this.replyWidgetColor = const Color(0xffF4F4F5),
      this.replyIconColor = Colors.blue,
      this.replyCloseColor = Colors.black12,
      this.messageBarColor = const Color(0xffF4F4F5),
      this.sendButtonColor = Colors.blue,
      this.onTextChanged,
      this.onSend,
      this.onTapCloseReply,
      this.sendbutton});

  /// [MessageBar] builder method
  ///
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: messageBarColor,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: UsyncTextField(
                    textController: textController,
                    keyboardType: TextInputType.text,
                    placeholderString: "message....",
                    suffix: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.emoji_emotions,
                        ),
                      ),
                    ),
                  ),
                ),
                ...actions,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
