import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/view_models/chat_view/conversation_list_view_model.dart';
import 'package:usync/pages/conversation/chat_list/conversation/list_component_view.dart';
import 'package:usync/pages/conversation/new_conversation/new_conversation.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
import 'package:usync/ui_components/globalcomponents/photo_grid.dart';
import 'package:usync/utils/place_holder.dart';
import 'package:usync/utils/theme_color.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key, required this.title});

  final String title;

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  TextEditingController search = TextEditingController();
  bool showSearch = false;
  ValueNotifier<bool> isSearchNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    



    return ValueListenableBuilder<bool>(
      valueListenable: isSearchNotifier,
      builder: (context, isSearch, _) {
        return ViewModelBuilder<CoversationListViewModel>.reactive(
          viewModelBuilder: () => CoversationListViewModel(),
          onViewModelReady: (model) => model.getData(),
          builder: (context, model, child) {
            List<dynamic> conversation = model.conversationList;

            List<User> userList = model.getConversationUsers(conversation);

            List<dynamic> searchConversation = model.conversationSearchList;


            TextEditingController search = TextEditingController();

// Add a listener to the TextEditingController
search.addListener(() {
  // Get the current text in the search field
  String searchText = search.text;
  
  // Call the method to update conversationSearchList in the ViewModel
  model.getSearchData(searchText);
  
  // Call setState to rebuild the widget tree and show the updated search results
  setState(() {});
});

            return AppPanel(
              radius: AppPanelRadius.xs,
              content: [
                AppPanelHeader(
                  search: true,
                  onSearchInput: (searchInput) {
                    model.getSearchData(searchInput);
                    setState(() {
                      showSearch = true;
                    });
                  },
                  onSearchCancel: () {
                    showSearch = isSearchNotifier.value;
                  },
                  toolbarHeight: 65,
                  actionButtons: [
                    IconButton(
                      icon: const FaIcon(
                        Icons.add_circle_outline,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const NewConversationPage(title: '');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                  isSearchNotifier: isSearchNotifier,
                  child: const Text('Conversations'),
                ),
                isSearchNotifier.value == false
                    ? Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(2),
                          itemCount: conversation.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            //debugPrint(conversation[index].users[0].name.toString());

                            return ConversationList(
                              name: model.getNames(conversation[index]),
                              messageText:
                                  conversation[index].lastMessage?.content ??
                                      "",
                              imageUrl: model.getAvatar(conversation[index]),
                              time: model.getDate(conversation[index]),
                              isMessageRead:
                                  !(conversation[index].unseen_messages_count ==
                                      0),
                              convesationId: conversation[index]
                                  .lastMessage
                                  .conversation_id,
                            );
                          },
                        ),
                      )
                    : Expanded(
                     
                        child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Container(
                                  color: ThemeColor().bgThemecolor(context),
                                  height: 138,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: userList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Avatar(
                                                imageUrl: model
                                                    .getUserAvatar(userList[index]),
                                                size: 32,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  model.stripHtmlIfNeeded(
                                                      userList[index]
                                                              .name!['full']
                                                              ?.replaceAll(
                                                                  ' ', '\n') ??
                                                          ''),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                showSearch == true
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 15),
                                          child: Text(
                                            'Conversations',
                                            style: const TextTheme().body(
                                              context,
                                              FontWeight.bold,
                                              FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                showSearch == true
                                    ? SizedBox(
                                          height: (searchConversation.length) * 85,
                                          child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(2),
                                            itemCount: searchConversation.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              //debugPrint(conversation[index].users[0].name.toString());
                                              return ConversationList(
                                                name: model.getNames(
                                                    searchConversation[index]),
                                                messageText: searchConversation[index]
                                                        .lastMessage
                                                        ?.content ??
                                                    "",
                                                imageUrl: model.getAvatar(
                                                    searchConversation[index]),
                                                time: model.getDate(
                                                    searchConversation[index]),
                                                isMessageRead:
                                                    !(searchConversation[index]
                                                            .unseen_messages_count ==
                                                        0),
                                                convesationId:
                                                    searchConversation[index]
                                                        .lastMessage
                                                        .conversation_id,
                                              );
                                            },
                                          ),
                                        )
                                      
                                    : const SizedBox.shrink(),
                                AppPanelSection(
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 28, top: 28),
                                    child: Text(
                                      'Photos',
                                      style: const TextTheme().body(
                                        context,
                                        FontWeight.bold,
                                        FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  height: ((imageList.length / 2) * 250) + 270,
                                  body: [
                                    SizedBox(
                                      width: width,
                                      child: const PhotoGrid(),
                                    ),
                                  ],
                                  direction: Axis.vertical,
                                  gutter: 0,
                                ),
                              ],
                            ),
                        ),
                      ),
                    
              ],
            );
          },
        );
      },
    );
  }
}
