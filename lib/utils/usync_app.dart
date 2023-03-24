// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:connectanum/connectanum.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_persist/redux_persist.dart'
    show JsonSerializer, Persistor;
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:usync/services/audio_call/audio_call_state.dart';

class UsyncApp {
  static final UsyncApp instance = UsyncApp._init();

  UsyncApp._init();

  late bool cordova = false;

  late bool flutter = false;

  late AppEnv appEnv;

  late Map authUser;

  late String authUserID;

  late String authToken;

  late Client client;

  late Session session;

  late Store<RAudioCallState> store;

  Future<void> setAppEnv(Map appEnvData) async {
    appEnv = AppEnv(
        env: appEnvData["APP"]["COOKIE_NAME"],
        baseUrl: appEnvData["APP"]["BASE_URL"],
        apiUrl: appEnvData["APP"]["API_URL"],
        socketUrl: appEnvData["APP"]["SOCKET_URL"],
        gossipAppUrl: appEnvData["APP"]["GOSSIP_APP_URL"],
        gossipServiceUrl: appEnvData["APP"]["GOSSIP_SERVICE_URL"],
        livekitServiceUrl: appEnvData["APP"]["LIVEKIT_SERVICE_URL"]);
  }

  Future<void> setAuthData(Map authData) async {
    authToken = authData['authToken'];
    if (authData.containsKey("authUser")) {
      authUser = authData['authUser'];
      authUserID = authData['authUser']['id'];
      await setAuthUserID(authUserID, authToken)(store);
    } else {
      final data = await _fetchAuthUser(authToken);
      authUser = data['activeUser'];
      authUserID = data['activeUser']['id'];
      await setAuthUserID(authUserID, authToken)(store);
    }
    return;
  }

  Future<Map> _fetchAuthUser(String token) async {
    var url = Uri.parse(
        "${UsyncApp.instance.appEnv.apiUrl}auth?include=communityUser.manageablePages.avatar,communityUser.manageablePages.cover,activeUser.avatar,activeUser.cover,communityUser.avatar,communityUser.cover,communities,role,language,settings");
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    final data = response.body;
    return jsonDecode(data);
  }

  Future<void> initStore() async {
    final persistor = Persistor<RAudioCallState>(
        storage: FlutterStorage(),
        debug: true,
        serializer: JsonSerializer<RAudioCallState>(RAudioCallState.fromJson));

    final initialState = await persistor.load();

    store = Store<RAudioCallState>(audioCallStateReducer,
        initialState: initialState ?? RAudioCallState.defaultState(),
        middleware: [persistor.createMiddleware(), thunkMiddleware]);
  }
}

String resolveMediaUrl(
    {required Map media, String? size, String? path, String? fallback}) {
  path ??= "";
  fallback ??= "";

  final mediaSize = size != null &&
          ["jpeg", "jpg", "png"].contains(media["original_extension"])
      ? "_$size"
      : "";
  final mediaExtension = media["original_extension"] == "jpeg"
      ? "jpg"
      : media["original_extension"] == "png"
          ? "jpg"
          : media["original_extension"];

  if (mediaExtension == null) {
    return fallback;
  }

  return "${UsyncApp.instance.appEnv.baseUrl}/$path$mediaSize.$mediaExtension";
}

class Media {}

class AppEnv {
  AppEnv({
    required this.env,
    this.cookieName = "",
    required this.apiUrl,
    required this.baseUrl,
    required this.socketUrl,
    required this.gossipAppUrl,
    required this.gossipServiceUrl,
    required this.livekitServiceUrl,
  });

  String env;
  String apiUrl;
  String baseUrl;
  String socketUrl;
  String gossipAppUrl;
  String gossipServiceUrl;
  String livekitServiceUrl;
  String? cookieName;
}
