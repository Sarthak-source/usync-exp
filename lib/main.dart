// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:io';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usync/config/config.dart';
import 'package:usync/data/models/hive_coversation/conversation.dart';
import 'package:usync/data/models/hive_default_conversation/default_conversation_preferences.dart';
import 'package:usync/data/models/hive_file/file.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/pages/now_playing/now_playing.dart';
import 'package:usync/pages/onboarding/login.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'data/models/hive_messages/message.dart';
import 'data/models/hive_pages/page.dart';
import 'pages/conversation/chat_list/conversation_page.dart';
import 'ui_components/config/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  CleanApi.instance.setup(baseUrl: MyConfig.appApiUrl);
  //Shared Pref Initialization
  await initialize();
  // TODO: Intialize a state management
  // TODO: Reload shared preferences
  // TODO: load access token from shared preferences to store
  await Hive.initFlutter();

  Hive.registerAdapter(ConversationAdapter());
  Hive.registerAdapter(DefaultConversationPreferencesAdapter());
  Hive.registerAdapter(FileAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(PageAdapter());
  Hive.registerAdapter(UserAdapter());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    EasyDynamicThemeWidget(
      child: const MyApp(),
    ),
  );
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
      home: const LoginScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
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
                    color: LightThemeColors.primary,
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
                    color: LightThemeColors.primary,
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
                    color: LightThemeColors.primary,
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
                    color: LightThemeColors.primary,
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
