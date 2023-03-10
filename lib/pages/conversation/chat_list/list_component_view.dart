import 'package:flutter/material.dart';
import 'package:usync/ui_components/avatar.dart';
import 'chat_page.dart';

class ConversationList extends StatefulWidget {
  final String name;
  final String? messageText;
  final List<String> imageUrl;
  final String time;
  final String convesationId;
  final bool isMessageRead;
  const ConversationList(
      {super.key,
      required this.name,
      this.messageText,
      required this.imageUrl,
      required this.time,
      required this.convesationId,
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
              return ChatDetailPage(
                convesationId: widget.convesationId,
                imageUrl: widget.imageUrl,
              );
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
                  Avatar(
                    imageUrl: widget.imageUrl,
                    size: 25,
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
                              SizedBox(
                                width: 160,
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
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
