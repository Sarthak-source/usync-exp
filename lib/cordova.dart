import 'dart:convert';

import 'package:flutter/services.dart';
import 'utils/json.dart';

class CordovaFlutterPlatformChannel {
  static const cordovaToFlutterChannelName = 'app.channel.shared.flutter.data';

  static const platform = MethodChannel('app.channel.shared.cordova.data');

  MethodChannel cordovaToFlutterChannel =
      const MethodChannel(cordovaToFlutterChannelName);

  static final CordovaFlutterPlatformChannel instance =
      CordovaFlutterPlatformChannel._init();

  CordovaFlutterPlatformChannel._init();

  static Map<String, List<void Function(dynamic)>> callbackContextMap = {};

  void configureChannel() {
    cordovaToFlutterChannel
        .setMethodCallHandler(cordovaToFlutterChannelHandler);
  }

  static Future<dynamic> invokeMethod(
      String methodName, Map<String, Object> argsJsonObj) async {
    var data = await platform.invokeMethod(methodName, argsJsonObj);
    return data;
  }

  static Future<dynamic> finish(Map<String, Object> para) async {
    var data = await invokeMethod("finish", para);
    return data;
  }

  static Future<dynamic> publish(
      String eventName, Map<String, Object> params) async {
    try {
      var argsJsonObj = [eventName, params];
      var data = await platform.invokeMethod("publish", argsJsonObj);
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<dynamic> open(String routeName) async {
    var argsJsonObj = [routeName];
    var data = await platform.invokeMethod("open", argsJsonObj);
    return data;
  }

  static Future<dynamic> back() async {
    var data = await platform.invokeMethod("back");
    return data;
  }

  static on(String eventName, void Function(dynamic) callback) async {
    List<void Function(dynamic)>? callbackContextList =
        callbackContextMap.containsKey(eventName)
            ? callbackContextMap[eventName]
            : [];

    callbackContextList?.add(callback);

    callbackContextMap[eventName] = List<void Function(dynamic)>.from(
        callbackContextList as Iterable<dynamic>);
  }

  Future<void> cordovaToFlutterChannelHandler(MethodCall call) async {
    final String data = call.arguments;
    final String eventName = call.method;

    if (callbackContextMap.containsKey(eventName)) {
      List<void Function(dynamic)>? callbackContextList =
          callbackContextMap[eventName];

      callbackContextList?.forEach((void Function(dynamic) callback) {
        callback(
            isJson(data) ? json.decode(data) as Map<String, dynamic> : data);
      });
    }
  }
}
