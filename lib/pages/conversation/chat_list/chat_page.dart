import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:usync/data/view_models/conversation_view/message_view_model.dart';
import 'package:usync/data/view_models/user_view_model/user_view_model.dart';
import 'package:usync/pages/conversation/chat_list/utility/chatbubble.dart';
import 'package:usync/pages/conversation/chat_list/utility/chatimage.dart';
import 'package:usync/pages/conversation/chat_list/utility/messagebar.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
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
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        viewModelBuilder: () => UserViewModel(),
        builder: (context, usermodel, child) {
          dynamic activeUser = usermodel.user;
          return ViewModelBuilder<CoversationViewModel>.reactive(
              viewModelBuilder: () => CoversationViewModel(
                  convesationId: widget.convesationId, page: 0, limit: 10),
              onViewModelReady: (model) => model.getData(),
              builder: (context, model, child) {
                List<dynamic> messages = model.messageList;

                debugPrint('chat--------$messages');

                bool isSender(int i) {
                  if (activeUser.id == messages[i].user.id) {
                    return true;
                  } else {
                    return false;
                  }
                }

                debugPrint('user id--------${activeUser.id}');

                Color bubbleColor(int i) {
                  if (activeUser.id == messages[i].user.id) {
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
                  // } else {
                  //   return BubbleNormalImage(
                  //     id: 'id001',
                  //     image: FadeInImage.memoryNetwork(
                  //         placeholder: kTransparentImage,
                  //         image:
                  //             'https://www.mensjournal.com/wp-content/uploads/2018/06/man-weight-lifting.jpg?w=940&h=529&crop=1&quality=86&strip=all'),
                  //     bubbleRadius: BUBBLE_RADIUS_IMAGE,
                  //     color: Colors.transparent,
                  //     tail: true,
                  //     isSender: isSender,
                  //     //delivered: true,
                  //   );
                  // }
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
                                subpaneldetails(context),
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
                      child: AppPanelSection(
                        height: 0,
                        body: [
                          SingleChildScrollView(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return bubble(
                                  index,
                                  isSender(index),
                                  bubbleColor(index),
                                );
                              },
                            ),
                          ),
                        ],
                        gutter: 0,
                        direction: Axis.horizontal,
                        alignment: CrossAxisAlignment.stretch,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MessageBar(
                        messageBarColor: ThemeColor().themecolor(context),
                        // ignore: avoid_print
                        sendbutton: false,
                        //onSend: (_)
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 8),
                            child: InkWell(
                              child:
                                  const FaIcon(FontAwesomeIcons.cloudArrowUp),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: InkWell(
                              child: const FaIcon(FontAwesomeIcons.gif),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: InkWell(
                              child:
                                  const FaIcon(FontAwesomeIcons.messageDollar),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        });
  }
}
