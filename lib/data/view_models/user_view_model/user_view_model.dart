import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/config/config.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class UserViewModel extends BaseViewModel {
  final APIService _apiService = APIService();
  final HiveService _hiveService = HiveService();
  String _text = "";
  String get text => _text;
  dynamic _user = User();
  dynamic get user => _user;
  String loginUrl = API.login;

  getUserHive() async {
    debugPrint("Entered get Data()");
    _text = "Fetching data";
    bool exists = await _hiveService.isExists(boxName: MyConfig.user);
    if (exists) {
      _text = "Fetching from hive";
      debugPrint("Getting user from Hive");
      setBusy(true);
      _user = await _hiveService.getBoxes(MyConfig.user);
      debugPrint(_user.toString());
      setBusy(false);
    } else {
      await getUser();
      setBusy(true);
    }
  }

  getUser() async {
    _text = "Fetching from hive";
    debugPrint("Getting data from Api");
    setBusy(true);
    var result = await _apiService.getRequest(
      loginUrl,
      bearerToken: true,
    );

    if (result.statusCode == 200) {
      final userMap = await _apiService.handleResponse(result);

      final user = User(
        id: userMap['id'] as String?,
        type: userMap['type'] as String?,
        name: userMap['name'] != null
            ? Map<String, String>.from(userMap['name'] as Map)
            : null,
        account: userMap['account'],
        //avatar: avatar,
        avatar_id: userMap['avatar_id'] as String?,
        cover_id: userMap['cover_id'] as String?,
        avatar_data: userMap['avatar_data'],
        cover_data: userMap['cover_data'],
        sub_title: userMap['sub_title'] as String?,
        description: userMap['description'],
        description_summary: userMap['description_summary'],
        isFirstView: userMap['isFirstView'] as bool? ?? false,
        settings: userMap['settings'] != null
            ? Map<String, dynamic>.from(userMap['settings'] as Map)
            : {},
        username: userMap['username'] as String?,
        preferences: userMap['preferences'] != null
            ? Map<String, dynamic>.from(userMap['preferences'] as Map)
            : {},
      );

      _user = await _hiveService.addBoxItem(user, MyConfig.user);

      debugPrint('LOGIN--USER--$user');
    }
  }
}
