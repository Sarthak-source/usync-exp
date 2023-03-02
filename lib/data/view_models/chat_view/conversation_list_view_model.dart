import 'package:flutter/material.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_coversation/conversation.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class CoversationListViewModel extends BaseViewModel {
  final HiveService hiveService = HiveService();
  final APIService apiService = APIService();

  List<Conversation> _conversationList = [];
  List<Conversation> get conversationList => _conversationList;
  String _text = "";
  String get text => _text;

  final String conversationUrl = API.conversation;

  getData() async {
    debugPrint("Entered get Data()");
    _text = "Fetching data";
    bool exists = await hiveService.isExists(boxName: "ConversationList");
    if (exists) {
      _text = "Fetching from hive";
      debugPrint("Getting data from Hive");
      setBusy(true);
      _conversationList = await hiveService.getBoxes("ConversationList");
      setBusy(false);
    } else {
      _text = "Fetching from hive";
      debugPrint("Getting data from Api");
      setBusy(true);
      var result = await apiService.getRequest(conversationUrl);
      (result as List).map((e) {
        Conversation conversation = Conversation(
          id: e['id'],
          type: e['type'],
          user_id: e['user_id'],
          created_at: e['created_at'],
          updated_at: e['updated_at'],
        );
        _conversationList.add(conversation);
      }).toList();
      _text = "Caching data";
      await hiveService.addBoxes(_conversationList, "ConversationList");
      setBusy(false);
    }
  }
}
