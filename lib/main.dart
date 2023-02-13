// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const MyHomePage(title: 'Conversation')),
    );
  }
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  List<String> imageUrl;
  String time;
  bool isMessageRead;
  ConversationList(
      {super.key,
      required this.name,
      required this.messageText,
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatDetailPage();
        }));
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
                            widget.messageText,
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

class ChatUsers {
  String name;
  String messageText;
  List<String> imageURL;
  String time;
  bool isMessageRead;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
    required this.isMessageRead,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(
        name: "Ann Williamson",
        time: "4:42 PM",
        imageURL: [
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png'
        ],
        messageText:
            'Hey, just checking on you, haven\'t heard from you in a a while. Hope you\'re doing well!',
        isMessageRead: false,
      ),
      ChatUsers(
        name: "Devon Fisher, Sarah Beck",
        time: "2:20 PM",
        imageURL: [
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
          'https://imgv3.fotor.com/images/blog-cover-image/part-blurry-image.jpg'
        ],
        messageText: 'Are we still on for tonight?',
        isMessageRead: false,
      ),
      ChatUsers(
        name: "Evan Simmons",
        time: "Yesterday",
        imageURL: [
          'https://images.pexels.com/photos/775358/pexels-photo-775358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
        ],
        messageText:
            'Read your story and it was extremely inspiring to see your struggle and what you\'ve accomplish...',
        isMessageRead: true,
      ),
      ChatUsers(
        name: "Kristin Flores",
        time: "Sunday",
        imageURL: [
          'https://images.pexels.com/photos/2709388/pexels-photo-2709388.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
        ],
        messageText: 'Hey cutie, its been a while. Lets catch up!',
        isMessageRead: true,
      ),
      ChatUsers(
        name: "Courtney Nguyen",
        time: "4/11/20",
        imageURL: [
          'https://images.pexels.com/photos/3586798/pexels-photo-3586798.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
        ],
        messageText:
            'Hey, just checking on you, haven\'t heard from you in a a while. Hope you\'re doing well!',
        isMessageRead: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        toolbarHeight: 70.0,
        elevation: 1,
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.grey,
          ),
        ),
        leadingWidth: 30,
        title: const Text(
          'Conversations',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              size: 25,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.add_circle_outline,
              size: 25,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chatUsers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ConversationList(
            name: chatUsers[index].name,
            messageText: chatUsers[index].messageText,
            imageUrl: chatUsers[index].imageURL,
            time: chatUsers[index].time,
            isMessageRead: chatUsers[index].isMessageRead,
          );
        },
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Column(
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
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 6,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
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
          MessageBar(
            messageBarColor: Colors.white,
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
        ],
      ),
    );
  }
}
