import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/models/conversation_models.dart/chat_user.dart';
import 'package:usync/pages/conversation/chat_list/conversation_list.dart';
import 'package:usync/pages/conversation/chat_list/conversation_details.dart';
import 'package:usync/utils/place_holder.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
import 'package:usync/ui_components/globalcomponents/sub_panel.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key, required this.title});

  final String title;

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  Widget build(BuildContext context) {
    return AppPanel(
      radius: AppPanelRadius.xs,
      content: [
        AppPanelHeader(
          search: true,
          toolbarHeight: 65,
          onBackClick: () {},
          onSearchCancel: () {},
          onSearchInput: (p0) {},
          actionButtons: [
            IconButton(
              icon: const FaIcon(
                Icons.add_circle_outline,
              ),
              onPressed: () {},
            ),
          ],
          child: const Text(
            'Conversations',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: chatUsers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ConversationList(
                name: chatUsers[index].name,
                messageText: chatUsers[index].messageText,
                imageUrl: chatUsers[index].imageURL,
                time: chatUsers[index].time,
                isMessageRead: chatUsers[index].isMessageRead,
              );
            },
          ),
        ),
      ],
    );
  }
}
