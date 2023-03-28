// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';
import 'package:connectanum/connectanum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usync/services/audio_call/audio_call_bg_service.dart';
import 'package:usync/utils/cordova_handler.dart';
import 'package:usync/utils/local_notifications.dart';
import 'package:usync/utils/usync_app.dart';


Future<FlutterBackgroundService> initializeBgService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: false,

      // notificationChannelId: 'my_foreground',
      // initialNotificationTitle: 'AWESOME SERVICE',
      // initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 1,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();

  return Future.value(service);
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  await UsyncApp.instance.initStore();
  await loadEnv();
  await initLocalNotificationsPlugins();

  FlutterPlatformChannelManager channelManager =
      FlutterPlatformChannelManager(service);

  Session? session;

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  AudioCallBgService.instance.setBgServiceInstance(service);
  AudioCallBgService.instance
      .setNotificationsManager(flutterLocalNotificationsPlugin);

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  debugPrint('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

  channelManager.onAuthData.listen((event) async {
    AudioCallBgService.instance.callerUserId = UsyncApp.instance.authUserID;
    if (session == null) {
      session = await createSession(UsyncApp.instance.appEnv.gossipServiceUrl,
          UsyncApp.instance.authToken, UsyncApp.instance.authUserID);

      AudioCallBgService.instance.session = session;
      AudioCallBgService.instance.openSession();
    }
  });
}
