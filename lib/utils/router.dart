import 'package:usync/utils/cordova.dart';
import 'package:usync/utils/usync_app.dart';

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
