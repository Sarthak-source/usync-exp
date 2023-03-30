import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/view_models/chat_view/conversation_list_view_model.dart';
import 'package:usync/data/view_models/search_view_model/search_view_model.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/customtext/customtext.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/prefered_size.dart';
import 'package:usync/utils/theme_color.dart';

class NewGroupConversation extends StatefulWidget {
  const NewGroupConversation({super.key});

  @override
  State<NewGroupConversation> createState() => _NewGroupConversationState();
}

class _NewGroupConversationState extends State<NewGroupConversation> {
  List<User> userList = [];
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      onViewModelReady: (searchModel) => searchModel.getSearch(search.text),
      builder: (context, searchModel, child) {
        List<User> users = searchModel.searchList;

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
                actionButtons: const [],
                bottomWidget: buildPreferredSizeWidget(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 45,
                        child: Autocomplete<User>(
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      CupertinoIcons.chevron_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                controller: textEditingController,
                                focusNode: focusNode,
                                onChanged: (value) {
                                  search.clear();
                                },
                                onSubmitted: (value) {
                                  search.clear();
                                },
                              ),
                            );
                          },
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            // You can replace this with your own logic for retrieving suggestions
                            final suggestions = users
                                .where((User option) => option.name!['full']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()))
                                .toList();

                            return suggestions;
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<User> onSelected,
                              Iterable<User> options) {
                                // onSelected(User option){
                                //   search.clear();
                                // }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Material(
                                color: ThemeColor().bgThemecolor(context),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                elevation: 10,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final User option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        
                                        onSelected(option);
                                        setState(
                                          () {
                                            if (searchModel.userExists(
                                                userList, option)) {
                                            } else {
                                              search.text=option.name!['full']??"";
                                              userList.add(option);
                                            }
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        leading: Avatar(
                                          imageUrl:
                                              searchModel.getImage(option),
                                          size: 20,
                                        ),
                                        title: Text(
                                          '${option.name!['full']}',
                                        ),
                                        subtitle: const Text('User'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          optionsMaxHeight: 25,
                        ),
                      ),
                    ),
                    preferredHeight: 50),
           
                child: const Text(
                  'New Group Conversation',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: userList.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(2),
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final item = userList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                debugPrint('chat page');
                              },
                              child: ListTile(
                                leading: Avatar(
                                  imageUrl: searchModel.getImage(item),
                                  size: 20,
                                ),
                                title: Text(item.name!['full'] ?? ''),
                                trailing:
                                    const Icon(CupertinoIcons.chevron_forward),
                              ),
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 103),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Search People To Start A Interesting  \n🙂 Conversation',
                            style: const TextTheme().title3(
                                context, FontWeight.normal, FontStyle.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ),
            userList.isNotEmpty
                ? ViewModelBuilder<CoversationListViewModel>.reactive(
                    viewModelBuilder: () => CoversationListViewModel(),
                    onViewModelReady: (conversationModel) => conversationModel,
                    builder: (context, conversationModel, child) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 10),
                          child: SizedBox(
                            width: width,
                            child: CupertinoButton(
                              color: LightThemeColors.primary,
                              onPressed: () async {
                                conversationModel.postData(
                                    searchModel.getUserIDList(userList), "hi");
                              },
                              child: Text(
                                "Start Conversation",
                                style: const TextTheme().body(
                                  context,
                                  FontWeight.normal,
                                  FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : Container(),
          ],
        );
      },
    );
  }
}
