import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_module/background_main.dart';
import 'package:flutter_module/config/theme_colors.dart';
import 'package:flutter_module/pages/audio_call_page.dart';
import 'package:flutter_module/pages/welcome_page.dart';
import 'package:flutter_module/services/audio_call_fg_service.dart';
import 'package:flutter_module/services/platform_bg_service.dart';
import 'package:flutter_module/usync_app.dart';
import 'cordova_handler.dart';
import 'local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  await dotenv.load(fileName: "env.usync");
  await UsyncApp.instance.setAppEnv({"APP": dotenv.env});
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Main app
Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  //  COmmon
  final service = await initializeBgService();
  initAudioCallFgService(service);
  await loadEnv();
  await UsyncApp.instance.initStore();

  initLocalNotificationsPlugins();

  runApp(StoreProvider(
      store: UsyncApp.instance.store, child: const UsyncAppMain()));

  await initCordovaFlutterPlatformChannel();
  // initBackgroundService();
}

class UsyncAppMain extends StatelessWidget {
  const UsyncAppMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'uSync',
      theme: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: ThemeColors.primaryColor,
          primaryContrastingColor: ThemeColors.primaryColor,
          textTheme: CupertinoTextThemeData(
              primaryColor: ThemeColors.primaryColor,
              textStyle:
                  TextStyle(color: ThemeColors.textColor, fontSize: 18.0),
              actionTextStyle:
                  TextStyle(backgroundColor: ThemeColors.primaryColor)),
          barBackgroundColor: null,
          scaffoldBackgroundColor: ThemeColors.pageBgColor),
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const AudioCallPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
