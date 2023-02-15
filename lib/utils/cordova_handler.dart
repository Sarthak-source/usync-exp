import 'dart:async';

import 'package:flutter_module/services/audio_call_state.dart';
import 'package:flutter_module/services/call_details.dart';

import 'cordova.dart';
import 'usync_app.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> initCordovaFlutterPlatformChannel() async {
  CordovaFlutterPlatformChannel.instance.configureChannel();

  CordovaFlutterPlatformChannel.on('appData', (data) async {
    FlutterBackgroundService().invoke('appData', data);
    await UsyncApp.instance.setAppEnv(data);
    UsyncApp.instance.cordova = true;
  });

  CordovaFlutterPlatformChannel.on('authData', (data) async {
    // ignore: avoid_print
    // print('authData');
    // print(data);
    FlutterBackgroundService().invoke('authData', data);
    await UsyncApp.instance.setAuthData(data);
  });

  CordovaFlutterPlatformChannel.on('startCall', (data) async {
    final callDetails =
        CallDetails.mapFromJson(Map<String, dynamic>.from(data));
    await updateCallDetails(callDetails)(UsyncApp.instance.store);
  });

  CordovaFlutterPlatformChannel.publish("initSuccessful", {});
  CordovaFlutterPlatformChannel.publish("getAuthData", {});
}

class FlutterPlatformChannelManager {
  late StreamController _appDataStreamController;
  late StreamController _authDataStreamController;
  late ServiceInstance _bgService;

  FlutterPlatformChannelManager(ServiceInstance service) {
    _bgService = service;
    _appDataStreamController = StreamController();
    _authDataStreamController = StreamController();
    // CordovaFlutterPlatformChannel.instance.configureChannel();
  }

  Stream get onAppData {
    _bgService.on('appData').listen((data) async {
      if (data != null) {
        await UsyncApp.instance.setAppEnv(data);
        UsyncApp.instance.cordova = true;
        _appDataStreamController.add(data);
      }
    });

    return _appDataStreamController.stream;
  }

  Stream get onAuthData {
    _bgService.on('authData').listen((data) async {
      if (data != null) {
        print({"authData": data});
        await UsyncApp.instance.setAuthData(data);
        // await resetAudioCallState()(UsyncApp.instance.store);
        _authDataStreamController.add(data);
      }
    });
    return _authDataStreamController.stream;
  }
}
