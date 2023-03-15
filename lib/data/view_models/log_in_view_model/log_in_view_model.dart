import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/config/config.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';
import 'package:usync/utils/redux_token.dart';

class LoginViewModel extends BaseViewModel {
  final APIService _apiService = APIService();

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;
  String loginUrl = API.login;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    // Implement your login logic here
    // Use _email and _password to make a request to your backend API
    // Handle success and failure cases as needed

    var result = await _apiService.postRequest(
      loginUrl,
      {'username': username, 'password': password},
    );

    if (result.statusCode == 200) {
      final decoded = await _apiService.handleResponse(result);
      final token = decoded['access_token'];

      setAccessToken(token)(ReduxToken.instance.store);
      await _apiService.setToken(MyConfig.access, token);
      // store the token securely for future API requests

      debugPrint('LOGIN--TOKEN--$token');
      return true;
    } else {
      // handle the error
      return false;
    }
  }
}
