import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/data/models/place_holder/conversation_models/chat_user.dart';
import 'package:usync/pages/conversation/chat_list/utility/messagebar.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/prefered_size.dart';
import 'package:usync/ui_components/usync_text_field.dart';
import 'package:usync/utils/place_holder.dart';
import 'package:usync/utils/theme_color.dart';

import 'new_group_conversation.dart';

class NewConversationPage extends StatefulWidget {
  const NewConversationPage({super.key, required this.title});

  final String title;

  @override
  State<NewConversationPage> createState() => _NewConversationPageState();
}

class _NewConversationPageState extends State<NewConversationPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    List<ChatUsers> conversation = chatUsers;
    TextEditingController message = TextEditingController();

    return AppPanel(
      radius: AppPanelRadius.xs,
      content: [
        SizedBox(
          height: 140,
          child: AppPanelHeader(
            search: false,
            toolbarHeight: 60,
            onBackClick: () {
              Navigator.pop(context);
            },
            onSearchCancel: () {},
            onSearchInput: (p0) {},
            actionButtons: const [],
            bottomWidget: buildPreferredSizeWidget(
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
                  child: UsyncTextField(
                    suffix: const Icon(Icons.search),
                    border: false,
                    textController: search,
                    placeholderString: 'To:',
                  ),
                ),
                50),
            child:  const Text(
                'Conversation',
            
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            debugPrint('chat page');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const NewGroupConversation();
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: Text(
                'New Group Conversation',
                style: const TextTheme().body(
                  context,
                  FontWeight.bold,
                  FontStyle.normal,
                ),
              ),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: Text(
            'Recent',
            style: const TextTheme().body(
              context,
              FontWeight.bold,
              FontStyle.normal,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(2),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('chat page');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const NewGroupConversation();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Avatar(
                        imageUrl: conversation[index].imageURL,
                        size: 20,
                      ),
                      title: Text(conversation[index].name),
                      trailing: const Icon(CupertinoIcons.chevron_forward),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: Text(
            'From your contacts',
            style: const TextTheme().body(
              context,
              FontWeight.bold,
              FontStyle.normal,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  leading: Avatar(
                    imageUrl: conversation[index].imageURL,
                    size: 20,
                  ),
                  title: Text(conversation[index].name),
                  trailing: CupertinoButton(
                    minSize: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: DarkThemeColors.secondary,
                    onPressed: () async {},
                    child: Text(
                      "Invite",
                      style: const TextTheme().subheadline(
                        context,
                        FontWeight.normal,
                        FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MessageBar(
            keyBoardType: TextInputType.none,
            messageBarColor: ThemeColor().themecolor(context),
            // ignore: avoid_print
            sendbutton: false,
            textController: message,
            onSend: () async {},
            //onSend: (_)
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 16),
                child: InkWell(
                  child: const FaIcon(FontAwesomeIcons.cloudArrowUp),
                  onTap: () {
                    //setState(() {
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
