import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_messages/message.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/view_models/chat_send_view_model/chat_send_view_model.dart';
import 'package:usync/data/view_models/conversation_view/message_view_model.dart';
import 'package:usync/data/view_models/user_view_model/user_view_model.dart';
import 'package:usync/pages/conversation/chat_list/utility/chatbubble.dart';
import 'package:usync/pages/conversation/chat_list/utility/messagebar.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/sub_panel.dart';
import 'package:usync/utils/theme_color.dart';

import 'conversation_details.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
    this.convesationId,
  });
  final String? convesationId;
  final String name;
  final List<String> imageUrl;

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late UserViewModel _usermodel;
  late CoversationViewModel _model;
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    _usermodel = UserViewModel();
    _model = CoversationViewModel(
        convesationId: widget.convesationId, page: 0, limit: 10);
    _usermodel.getUserHive();
    _model.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      viewModelBuilder: () => UserViewModel(),
      onViewModelReady: (usermodel) => usermodel.getUserHive(),
      builder: (context, usermodel, child) {
        dynamic accountId = usermodel.account.activeUser.id;
        return ViewModelBuilder<CoversationViewModel>.reactive(
          viewModelBuilder: () => CoversationViewModel(
              convesationId: widget.convesationId, page: 0, limit: 10),
          onViewModelReady: (model) => model.getData(),
          builder: (context, model, child) {
            List<dynamic> messages = model.messageList;

            debugPrint('chat--------$messages');

            debugPrint('chat--------$accountId');

            addMessage(Message message) {
              setState(() {
                messages.insert(0, message);
              });
            }

            bool isSender(bool activeUserOrNot) {
              if (activeUserOrNot) {
                return true;
              } else {
                return false;
              }
            }

            //debugPrint('user id--------${account.activeUser.id}');

            Color bubbleColor(bool activeUserOrNot) {
              if (activeUserOrNot) {
                return DarkThemeColors.primary;
              } else {
                return const Color(0xFFE8E8EE);
              }
            }

            Widget bubble(int i, bool isSender, Color bubbleColor) {
              //if (messages[i].user['type'] == 'message') {
              return BubbleSpecialThree(
                text: messages[i].content,
                color: bubbleColor,
                tail: true,
                isSender: isSender,
              );
            }

            return AppPanel(
              radius: AppPanelRadius.xs,
              content: [
                AppPanelHeader(
                  toolbarHeight: 90,
                  actionButtons: [
                    IconButton(
                      onPressed: () {
                        SubPanel().showSubPanel(
                            context,
                            subpaneldetails(
                                context, widget.name, widget.imageUrl),
                            1.1,
                            MainAxisAlignment.start);
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        //color: Colors.grey,
                      ),
                    ),
                  ],
                  back: true,
                  onBackClick: () {
                    debugPrint('back');
                    Navigator.pop(context);
                  },
                  alignment: true,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Avatar(
                        imageUrl: widget.imageUrl,
                        size: 25,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool activeUserOrNot =
                          (accountId == messages[index].user.id);

                      return bubble(
                        index,
                        isSender(activeUserOrNot),
                        bubbleColor(activeUserOrNot),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ViewModelBuilder<SendChatViewModel>.reactive(
                    viewModelBuilder: () =>
                        SendChatViewModel(convesationId: widget.convesationId),
                    onViewModelReady: (model) => model,
                    builder: (context, model, child) {
                      return MessageBar(
                        messageBarColor: ThemeColor().themecolor(context),
                        // ignore: avoid_print
                        sendbutton: false,
                        textController: message,
                        onSend: () async {
                          debugPrint(widget.convesationId);
                          var result = await model.sendChat(
                              message.text, widget.convesationId ?? '');

                          if (result) {
                            addMessage(Message(
                                content: message.text, user: User(id: accountId)));
                                message.clear();
                          } else {}
                        },
                        //onSend: (_)
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, right: 16),
                            child: InkWell(
                              child:
                                  const FaIcon(FontAwesomeIcons.cloudArrowUp),
                              onTap: () {},
                            ),
                          ),
                        ],
                      );
                    },
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
