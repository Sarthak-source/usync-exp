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

      final currentActiveUser = User(
        id: activeUserMap['id'] as String?,
        type: activeUserMap['type'] as String?,
        name: activeUserMap['name'] != null
            ? Map<String, String>.from(activeUserMap['name'] as Map)
            : null,
        account: activeUserMap['account'],
        //avatar: avatar,
        avatar_id: activeUserMap['avatar_id'] as String?,
        cover_id: activeUserMap['cover_id'] as String?,
        avatar_data: activeUserMap['avatar_data'],
        cover_data: activeUserMap['cover_data'],
        sub_title: activeUserMap['sub_title'] as String?,
        description: activeUserMap['description'],
        description_summary: activeUserMap['description_summary'],
        isFirstView: activeUserMap['isFirstView'] as bool? ?? false,
        settings: activeUserMap['settings'] as String?, 

        username: activeUserMap['username'] as String?,
        preferences: activeUserMap['preferences'] != null
            ? Map<String, dynamic>.from(activeUserMap['preferences'] as Map)
            : {},
      );

      

      var communityUserMap = userMap['communityUser'];

      final communityUser = User(
        id: communityUserMap['id'] as String?,
        type: communityUserMap['type'] as String?,
        name: communityUserMap['name'] != null
            ? Map<String, String>.from(communityUserMap['name'] as Map)
            : null,
        account: communityUserMap['account'],
        //avatar: avatar,
        avatar_id: communityUserMap['avatar_id'] as String?,
        cover_id: communityUserMap['cover_id'] as String?,
        avatar_data: communityUserMap['avatar_data'],
        cover_data: communityUserMap['cover_data'],
        sub_title: communityUserMap['sub_title'] as String?,
        description: communityUserMap['description'],
        description_summary: communityUserMap['description_summary'],
        isFirstView: communityUserMap['isFirstView'] as bool? ?? false,
        settings: communityUserMap['settings'] as String?, 

        username: communityUserMap['username'] as String?,
        preferences: communityUserMap['preferences'] != null
            ? Map<String, dynamic>.from(communityUserMap['preferences'] as Map)
            : {},
      );

      var users = userMap['users'];
      List<User> userList = [];

      for (var user in users) {
        if (user['avatar'] != null && user['avatar']['links'] != null) {
          File avatar = File(
            id: user['id'] ?? "",
            type_: user['_type'] ?? "",
            type: user['type'] ?? "",
            name: user['name']['full'] ?? "",
            description: user['description'] ?? "",
            description_summary: user['description_summary'] ?? "",
            poster_id: user['poster_id'] ?? "",
            cover: user['cover'],
            original_extension: user['original_extension'] ?? "",
            playable_length: user['playable_length'] ?? 0,
            data: user['data'] ?? {},
            user_id: user['user_id'] ?? 0,
            //user: fileMap['user'],
            page_id: user['page_id'] ?? "",
            //page: fileMap['page'],
            aspect_ratio: user['aspect_ratio'] ?? "",
            links: user['avatar'] != null ? user['avatar']['links'] ?? {} : {},
            timestamps: user['timestamps'] ?? {},
            manageable: user['manageable'] ?? false,
            //meta: fileMap['meta'] ?? false,
            marked_as_nsfw: user['marked_as_nsfw'] ?? false,
            m3u8_path: user['m3u8_path'] ?? "",
          );

          User indexedUser = User(
            id: user['id'] as String?,
            type: user['type'] as String?,
            name: user['name'] != null
                ? Map<String, String>.from(user['name'] as Map)
                : null,
            account: user['account'],
            avatar: avatar,
            avatar_id: user['avatar_id'] as String?,
            cover_id: user['cover_id'] as String?,
            avatar_data: user['avatar_data'],
            cover_data: user['cover_data'],
            sub_title: user['sub_title'] as String?,
            description: user['description'],
            description_summary: user['description_summary'],
            isFirstView: user['isFirstView'] as bool? ?? false,
            settings: user['settings'] as String?, 
            username: user['username'] as String?,
            preferences: user['preferences'] != null
                ? Map<String, dynamic>.from(user['preferences'] as Map)
                : {},
          );
          userList.add(indexedUser);
        }
      }

      var languageMap = userMap['language'];

      Language language = Language(
        id: languageMap['id'],
        code: languageMap['code'],
        display: languageMap['display'],
        isDefault: languageMap['isDefault'],
        isActive: languageMap['isActive'],
        isAutoGenerated: languageMap['isAutoGenerated'],
        createdAt: languageMap['createdAt'],
        updatedAt: languageMap['updatedAt'],
        type: languageMap['type'],
      );

      final accountCurrent = Account(
        status: userMap['status'] as String?,
        firstName: userMap['firstName'] as String?,
        middleName: userMap['middleName'] as String?,
        email: userMap['email'] as String?,
        gender: userMap['gender'] as String?,
        lastName: userMap['lastName'] as String?,
        language: language,
        timezone: userMap['timezone'],
        lastLoginAt: userMap['lastLoginAt'] as String?,
        doNotDisturb: userMap['doNotDisturb'] as int?,
        locationDetail: userMap['locationDetail'],
        isNewUser: userMap['isNewUser'] as bool?,
        phone: userMap['phone'] as String?,
        location: userMap['location'] as String?,
        birthdateAt: userMap['birthdateAt'] as String?,
        type: userMap['type'] as String?,
        activeUser: currentActiveUser,
        communityUser: communityUser,
        users: userList,
        communities: userMap['communities'],
        id: userMap['id'] as String?,
      );
      _account = await _hiveService.addBoxItem(accountCurrent, MyConfig.activeUser);

      debugPrint('LOGIN--USER--$account');
      setBusy(false);
    }
  }
}
