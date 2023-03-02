
import 'package:usync/config/config.dart';

class API {
  API._();
  static const String appName = MyConfig.appName;
  static const String appUrl = MyConfig.appUrl;

  /// Base URL
  //Point the API to the base URL
  static const base = MyConfig.appApiUrl;

  //

  //

  //

  /// User
  static const register = 'auth/register';
  static const login = 'auth/login';
  
  static const logout = 'auth/logout';
  static const userInfo = 'account/update';
  

  /// Forgot password & Reset
  static const forgot = 'auth/forgot';
  static const resetPasswordToken = 'auth/reset/token';
  static const resetPassword = 'auth/reset';

  /// Conversation
  static const conversation = 'conversations';
 
}
