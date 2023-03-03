import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_coversation/conversation.dart';
import 'package:usync/data/view_models/chat_view/conversation_list_view_model.dart';
import 'package:usync/pages/conversation/chat_list/conversation_list.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';

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
          child: ViewModelBuilder<CoversationListViewModel>.reactive(
            viewModelBuilder: () => CoversationListViewModel(),
            onViewModelReady: (model) => model.getData(),
            builder: (context, model, child) {
              List<Conversation> conversation = model.conversationList;
              return ListView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: conversation.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: conversation[index].name,
                    messageText: conversation[index].lastMessage?.content ?? "",
                    imageUrl: conversation[index].users[index].avatar_data,
                    time: conversation[index].updated_at.toString(),
                    isMessageRead: conversation[index].type!.isEmpty,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
