import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    debugPrint("Entered get Data()--chat");
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
      debugPrint('decoded---$decoded');
      (decoded['data'] as List).map((e) {
        debugPrint(
          e.toString(),
        );

        List<dynamic> users = e['users'];
        List<User> userList = [];
        for (var userMap in users) {
          File avatar = mapJsonToFile(userMap);

          User user = mapJsonToUser(userMap, avatar, File());
          userList.add(user);
        }

        Message lastMessage =
            mapJsonToMessage(e['lastMessage'], User(), Conversation());

        Conversation conversation =
            mapJsonToConversation(e, userList, lastMessage, [Message()]);
        _conversationList.add(conversation);
      }).toList();
      _text = "Caching data";
      await _hiveService.addBoxes(_conversationList, "ConversationList");
      setBusy(false);
    }
  }


  Future<bool> postData(List<String> users, String message) async {
    var result = await _apiService.postRequest(
      conversationUrl,
      {"users": users, "message": message},
      bearerToken: true,
    );

    if (result.statusCode == 200) {
      final decoded = await _apiService.handleResponse(result);

      debugPrint('NEW--CONVERSATION--$decoded');
      return true;
    } else {
      // handle the error
      return false;
    }
  }

  List<String> getAvatar(Conversation conversation) {
    var users = conversation.users;
    List<String> imageLinks = [];

    try {
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
    } catch (e) {
      debugPrint('Error occurred while getting image: $e');
    }

    return imageLinks;
  }

  List<Conversation> getFilteredConversation(List<dynamic> conversation) {
    List<Conversation> filteredConversationList = [];

    for (var i = 0; i < conversation.length; i++) {
      if (conversation[i].type != 'group') {
        debugPrint(conversation[i].type);
        filteredConversationList.add(conversation[i]);
      }
    }

    return filteredConversationList;
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  String getNames(Conversation conversation) {
    var users = conversation.users;
    List<String> nameList = [];

    for (var i = 0; i < users.length; i++) {
      var userNames = users[i].name;
      //debugPrint('user name ${users[i].name}');
      if (userNames != null) {
        //debugPrint(userNames.toString());
        nameList.add(userNames['full'] ?? '');
      }
    }

    final foldValue = nameList.join(", ");

    return stripHtmlIfNeeded(foldValue);
  }

  

  String getDate(Conversation conversation) {
    DateTime lastSeen = DateTime.parse(conversation.updated_at ?? '');
    final DateFormat formatter = DateFormat.yMMMd();
    final String formatted = formatter.format(lastSeen);
    return formatted;
  }
}
