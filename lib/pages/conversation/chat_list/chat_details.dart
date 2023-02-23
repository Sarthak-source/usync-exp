import 'package:flutter/material.dart';
import 'package:usync/pages/conversation/chat_list/utility/chatbubble.dart';
import 'package:usync/pages/conversation/chat_list/utility/chatimage.dart';
import 'package:usync/pages/conversation/chat_list/utility/messagebar.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
import 'package:usync/ui_components/globalcomponents/sub_panel.dart';
import 'package:usync/utils/theme_color.dart';

import 'conversation_details.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AppPanel(
      radius: AppPanelRadius.xs,
      content: [
        AppPanelHeader(
          actionButtons: [
            IconButton(
              onPressed: () {
                SubPanel().showSubPanel(context, subpaneldetails(context), 1.1,
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
            children: const [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                maxRadius: 20,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Sarah Williamson",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              SizedBox(
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
                child: Column(
                  children: [
                    const BubbleSpecialThree(
                      text: 'pizza?',
                      color: Color.fromARGB(255, 0, 186, 9),
                      tail: false,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const BubbleSpecialThree(
                      text: 'Let\'s do it! I\'m in a meeting until noon.',
                      color: Color.fromARGB(255, 0, 186, 9),
                      tail: false,
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const BubbleSpecialThree(
                      text:
                          'That\'s perfect. There\'s a new place on Main St I\'ve been wanting to check out. I hear their hawaiian pizza is off the hook!',
                      color: Color(0xFFE8E8EE),
                      tail: true,
                      isSender: false,
                    ),
                    BubbleNormalImage(
                      id: 'id001',
                      image: Image.network(
                          'https://www.mensjournal.com/wp-content/uploads/2018/06/man-weight-lifting.jpg?w=940&h=529&crop=1&quality=86&strip=all'),
                      bubbleRadius: BUBBLE_RADIUS_IMAGE,
                      color: Colors.transparent,
                      tail: true,
                      //delivered: true,
                    ),
                    const BubbleSpecialThree(
                      text:
                          "I don't know why people are so anti pineapple pizza. I kind of like it.",
                      color: Color(0xFFE8E8EE),
                      tail: true,
                      isSender: false,
                    )
                  ],
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
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.gif_box_outlined,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
