import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/config/config.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:usync/data/models/hive_account/account.dart';
import 'package:usync/data/models/hive_file/file.dart';
import 'package:usync/data/models/hive_language/language.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class UserViewModel extends BaseViewModel {
  final APIService _apiService = APIService();
  final HiveService _hiveService = HiveService();
  String _text = "";
  String get text => _text;
  dynamic _account = Account();
  dynamic get account => _account;
  String loginUrl = API.login;

  getUserHive() async {
    setBusy(true);
    _text = "Fetching data";
    bool exists = await _hiveService.isExists(boxName: MyConfig.activeUser);
    if (exists) {
      _text = "Fetching from hive";
      debugPrint("Getting user from Hive");

      _account = await _hiveService.getBoxItem(MyConfig.activeUser);
      debugPrint('user model');
      debugPrint(account.activeUser.id);
    } else {
      await getUser();
    }
    setBusy(false);
  }

  getUser() async {
    _text = "Fetching from API";
    debugPrint("Getting data from Api");
    setBusy(true);
    var result = await _apiService.getRequest(
      loginUrl,
      bearerToken: true,
      queryParams: {
        'include': [
          'communityUser.manageablePages.avatar',
          'communityUser.manageablePages.cover',
          'activeUser.avatar',
          'activeUser.cover',
          'communityUser.avatar',
          'communityUser.cover',
          'communities',
          'role',
          'language',
          'settings'
        ].join(',')
      },
    );

    if (result.statusCode == 200) {
      final userMap = await _apiService.handleResponse(result);

      debugPrint('userMap------$userMap');

      var activeUserMap = userMap['activeUser'];

      debugPrint('activeUserMap------${activeUserMap['id']}');

      final currentActiveUser = mapJsonToUser(activeUserMap, File(), File());

      var communityUserMap = userMap['communityUser'];

      final communityUser = mapJsonToUser(communityUserMap, File(), File());

      var users = userMap['users'];
      List<User> userList = [];

      for (var user in users) {
        if (user['avatar'] != null && user['avatar']['links'] != null) {
          File avatar = mapJsonToFile(user);

          User indexedUser = mapJsonToUser(user, avatar, File());
          userList.add(indexedUser);
        }
      }

      var languageMap = userMap['language'];

      Language language = mapJsonToLanguage(languageMap);

      final accountCurrent = mapJsonToAccount(
        userMap,
        language,
        currentActiveUser,
        communityUser,
        userList,
      );
      _account =
          await _hiveService.addBoxItem(accountCurrent, MyConfig.activeUser);

      debugPrint('LOGIN--USER--$account');
      setBusy(false);
    }
  }
}
