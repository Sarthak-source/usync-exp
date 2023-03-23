import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usync/data/models/place_holder/conversation_models/chat_user.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/prefered_size.dart';
import 'package:usync/ui_components/usync_text_field.dart';
import 'package:usync/utils/place_holder.dart';

class NewGroupConversation extends StatefulWidget {
  const NewGroupConversation({super.key});

  @override
  State<NewGroupConversation> createState() => _NewGroupConversationState();
}

class _NewGroupConversationState extends State<NewGroupConversation> {
  @override
  Widget build(BuildContext context) {
    List<ChatUsers> conversation = chatUsers;
    double width = MediaQuery.of(context).size.width;
    TextEditingController search = TextEditingController();
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
                    suffix: const Icon(CupertinoIcons.chevron_down),
                    border: false,
                    textController: search,
                    prifix: const Icon(CupertinoIcons.search),
                  ),
                ),
                50),
            child: const Text(
              'New Group Conversation',
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
            child: SizedBox(
              width: width,
              child: CupertinoButton(
                color: LightThemeColors.primary,
                onPressed: () async {},
                child:  Text("Start Conversation",style:  const TextTheme().body(
                    context,
                    FontWeight.normal,
                    FontStyle.normal,
                  ),),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
