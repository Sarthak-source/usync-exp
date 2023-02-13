import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import './usync_app.dart';
// import 'counter_service.dart';

class BackgroundService {
  static const backgroundServiceChannelName =
      'com.usync.flutter/background_service';
}

void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackground.enableBackgroundExecution();
}

void initBackgroundService() {
  // UsyncAppConfig.instance.initStore();
  // var channel =
  //     const MethodChannel(BackgroundService.backgroundServiceChannelName);
  // var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);
  // channel.invokeMethod('startService', callbackHandle?.toRawHandle());
}
