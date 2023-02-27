// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:usync/pages/now_playing/now_playing.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'pages/conversation/chat_list/conversation_page.dart';
import 'ui_components/config/theme/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(EasyDynamicThemeWidget(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = SchedulerBinding.instance.window.platformBrightness;

    return MaterialApp(
      title: 'usync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const ConversationsPage(title: 'Conversation'),
    const NowPlaying(),
    const ConversationsPage(title: 'Conversation'),
    const ConversationsPage(title: 'Conversation'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  buildMyNavBar(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NowPlaying();
                  },
                ),
              );
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
          ),
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: LightThemeColors.primary,
            padding: const EdgeInsets.all(10.0),
            shape: const CircleBorder(),
            child: const Icon(
              Icons.pause,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
