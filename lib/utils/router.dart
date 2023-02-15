import 'package:chatsampleapp/utils/cordova.dart';
import 'package:chatsampleapp/utils/usync_app.dart';

import '../main.dart';

class NavRouter {
  static final NavRouter instance = NavRouter._init();

  NavRouter._init();

  back() {
    if (UsyncApp.instance.cordova) {
      CordovaFlutterPlatformChannel.back();
    } else {
      navigatorKey.currentState?.pushNamed('/');
    }
  }

  toRoute(String routeName) {
    if (UsyncApp.instance.cordova) {
      CordovaFlutterPlatformChannel.open(routeName);
    } else {
      navigatorKey.currentState?.pushNamed(routeName);
    }
  }
}
