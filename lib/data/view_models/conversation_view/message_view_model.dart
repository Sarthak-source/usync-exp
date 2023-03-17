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

class CoversationViewModel extends BaseViewModel {
  final String? convesationId;
  final int? page; // <page number>
  final int? limit; // <per page limit>
//include - 'attachable.user,user'

  CoversationViewModel({
    required this.convesationId,
    this.page,
    this.limit,
  });

  final HiveService hiveService = HiveService();
  final APIService apiService = APIService();

  List<dynamic> _messageList = [];
  List<dynamic> get messageList => _messageList;
  String _text = "";
  String get text => _text;
  final ConnectivityService _connectivityService = ConnectivityService();
  final String messageUrl = API.messages;

  getData() async {
    bool checkConnectivity =
        await _connectivityService.checkInternetConnection();

    debugPrint("Entered get Data()");
    _text = "Fetching data";
    bool exists =
        await hiveService.isExists(boxName: "MessageList$convesationId");
    if (exists && (checkConnectivity == false)) {
      _text = "Fetching from hive";
      debugPrint("Getting data from Hive");
      setBusy(true);
      _messageList = await hiveService.getBoxes("MessageList$convesationId");
      setBusy(false);
    } else {
      _text = "Fetching from hive";
      debugPrint("Getting data from Api");
      setBusy(true);
      var result = await apiService.getRequest(
        messageUrl,
        bearerToken: true,
        queryParams: {
          'conversation': convesationId,
          // 'page': page,
          // 'limit': limit
        },
      );
      var decoded = await apiService.handleResponse(result);
      debugPrint('decoded---$decoded');
      notifyListeners();
      (decoded['data'] as List).map((e) {
        debugPrint(e.toString());

        var userMap = e['user'];

        // if (userMap['avatar'] != null && userMap['avatar']['links'] != null) {
        File avatar = mapJsonToFile(userMap);

        User user = mapJsonToUser(userMap, avatar, File());

        Message conversation = mapJsonToMessage(e, user, Conversation());
        _messageList.add(conversation);
      }).toList();
      _text = "Caching data";
      await hiveService.addBoxes(_messageList, "MessageList$convesationId");
      setBusy(false);
    }
  }
}
