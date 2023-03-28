import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/view_models/chat_view/conversation_list_view_model.dart';
import 'package:usync/data/view_models/contact_view_model/contact_view_model.dart';
import 'package:usync/pages/conversation/chat_list/utility/messagebar.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/prefered_size.dart';
import 'package:usync/ui_components/usync_text_field.dart';
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
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: UsyncTextField(
                    suffix: const Icon(Icons.search),
                    border: false,
                    textController: search,
                    placeholderString: 'To:',
                  ),
                ),
                preferredHeight: 50),
            child: const Text(
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
          child: ViewModelBuilder<CoversationListViewModel>.reactive(
              viewModelBuilder: () => CoversationListViewModel(),
              onViewModelReady: (model) => model.getData(),
              builder: (context, model, child) {
                List<dynamic> conversation = model.conversationList;
                List<dynamic> limitedConversation =
                    conversation.take(3).toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: limitedConversation.length,
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
                            imageUrl:
                                model.getAvatar(limitedConversation[index]),
                            size: 20,
                          ),
                          title: Text(
                            model.getNames(limitedConversation[index]),
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ),
                    );
                  },
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
          child: ViewModelBuilder<ContactViewModel>.reactive(
              viewModelBuilder: () => ContactViewModel(),
              onViewModelReady: (contactModel) =>
                  contactModel.requestContactsPermission(),
              builder: (context, contactModel, child) {
                List<Contact> contacts = contactModel.contacts;
                List<Contact> limitedContacts = contacts.take(3).toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: limitedContacts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: DarkThemeColors.secondary,
                          child: FaIcon(FontAwesomeIcons.addressBook),
                        ),
                        title: Text(limitedContacts[index].displayName ?? ''),
                        trailing: CupertinoButton(
                          minSize: 20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          color: DarkThemeColors.secondary,
                          onPressed: () async {
                            contactModel.sendSms(
                                '${limitedContacts[index].phones![0].value}',
                                'Hey this is message body');
                          },
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
                );
              }),
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
