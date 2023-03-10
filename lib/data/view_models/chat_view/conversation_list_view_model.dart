import 'package:flutter/material.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_coversation/conversation.dart';
import 'package:usync/data/models/hive_file/file.dart';
import 'package:usync/data/models/hive_messages/message.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';
import 'package:usync/utils/connectivity.dart';

class CoversationListViewModel extends BaseViewModel {
  final HiveService _hiveService = HiveService();
  final APIService _apiService = APIService();
  final ConnectivityService _connectivityService = ConnectivityService();

  List<dynamic> _conversationList = [];
  List<dynamic> get conversationList => _conversationList;
  String _text = "";
  String get text => _text;

  final String conversationUrl = API.conversation;

  getData() async {
    bool checkConnectivity =
        await _connectivityService.checkInternetConnection();

    debugPrint("Entered get Data()");
    _text = "Fetching data";
    bool exists = await _hiveService.isExists(boxName: "ConversationList");
    if (exists && (checkConnectivity == false)) {
      //await Hive.deleteFromDisk();

      _text = "Fetching from hive";
      debugPrint("Getting data from Hive");
      setBusy(true);
      _conversationList = await _hiveService.getBoxes("ConversationList");
      setBusy(false);
    } else {
      _text = "Fetching from hive";
      debugPrint("Getting data from Api");
      setBusy(true);
      var result =
          await _apiService.getRequest(conversationUrl, bearerToken: true);
      var decoded = await _apiService.handleResponse(result);
      debugPrint('decoded---$decoded["data"].toString()');
      (decoded['data'] as List).map((e) {
        debugPrint(
          e.toString(),
        );
        List<dynamic> users = e['users'];
        List<User> userList = [];
        for (var userMap in users) {
          if (userMap['avatar'] != null && userMap['avatar']['links'] != null) {
            File avatar = File(
              id: userMap['id'] ?? "",
              type_: userMap['_type'] ?? "",
              type: userMap['type'] ?? "",
              name: userMap['name']['full'] ?? "",
              description: userMap['description'] ?? "",
              description_summary: userMap['description_summary'] ?? "",
              poster_id: userMap['poster_id'] ?? "",
              cover: userMap['cover'],
              original_extension: userMap['original_extension'] ?? "",
              playable_length: userMap['playable_length'] ?? 0,
              data: userMap['data'] ?? {},
              user_id: userMap['user_id'] ?? 0,
              //user: fileMap['user'],
              page_id: userMap['page_id'] ?? "",
              //page: fileMap['page'],
              aspect_ratio: userMap['aspect_ratio'] ?? "",
              links: userMap['avatar'] != null
                  ? userMap['avatar']['links'] ?? {}
                  : {},
              timestamps: userMap['timestamps'] ?? {},
              manageable: userMap['manageable'] ?? false,
              //meta: fileMap['meta'] ?? false,
              marked_as_nsfw: userMap['marked_as_nsfw'] ?? false,
              m3u8_path: userMap['m3u8_path'] ?? "",
            );

            User user = User(
              id: userMap['id'] as String?,
              type: userMap['type'] as String?,
              name: userMap['name'] != null
                  ? Map<String, String>.from(userMap['name'] as Map)
                  : null,
              account: userMap['account'],
              avatar: avatar,
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
            userList.add(user);
          }
        }

        Message lastMessage = Message(
          content: e['lastMessage']['content'],
          conversation_id: e['lastMessage']['conversation_id'],
        );

        Conversation conversation = Conversation(
          id: e['id'],
          type: e['type'],
          name: e['name'] ?? '',
          //lastMessage: e['lastMessage'],
          user_id: e['user_id'],
          created_at: e['created_at'],
          updated_at: e['updated_at'],

          last_message_id: e['last_message_id'],
          messages: e['messages'],
          user_ids: e['user_ids'],
          users: userList,
          lastMessage: lastMessage,
          //preferences: e['preferences'],
          unseen_messages_count: e['unseen_messages_count'],
        );
        _conversationList.add(conversation);
      }).toList();
      _text = "Caching data";
      await _hiveService.addBoxes(_conversationList, "ConversationList");
      setBusy(false);
    }
  }

  List<String> getAvatar(Conversation conversation) {
    var users = conversation.users;
    List<String> imageLinks = [];

    for (var i = 0; i < users.length; i++) {
      var userAvatar = users[i].avatar;
      if (userAvatar != null) {
        var userAvatarLinks = userAvatar.links;
        if (userAvatarLinks != null) {
          String userAvatarUrl = userAvatarLinks['xs']['url'];
          debugPrint(userAvatarUrl);
          imageLinks.add(userAvatarUrl);
        }
      }
    }

    return imageLinks;
  }

  String getNames(Conversation conversation) {
    var users = conversation.users;
    List<String> nameList = [];

    for (var i = 0; i < users.length; i++) {
      var userNames = users[i].name;
      if (userNames != null) {
        debugPrint(userNames['full']);
        nameList.add(userNames['full'] ?? '');
      }
    }

    final foldValue = nameList.join(", ");

    return foldValue;
  }
}
