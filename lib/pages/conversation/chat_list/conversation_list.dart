import 'package:flutter/material.dart';
import 'package:usync/pages/conversation/chat_list/conversation_page.dart';
import 'package:usync/pages/conversation/chat_list/chat_details.dart';

class ConversationList extends StatefulWidget {
  final String name;
  final String? messageText;
  final List<String> imageUrl;
  final String time;
  final bool isMessageRead;
  const ConversationList(
      {super.key,
      required this.name,
      this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('chat page');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ChatDetailPage();
            },
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  widget.isMessageRead == false
                      ? const Icon(
                          Icons.circle,
                          size: 6,
                          color: Colors.green,
                        )
                      : Container(),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 50,
                    width: 65,
                    child: Stack(
                      children: [
                        for (var i = 0; i < widget.imageUrl.length; i++)
                          Positioned(
                            left: (i * (1 - .4) * 20).toDouble(),
                            top: 0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.imageUrl[i],
                              ),
                              radius: 25,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                padding: const EdgeInsets.all(5.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                widget.time,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText ?? '',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
