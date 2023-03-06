import 'package:flutter/material.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_messages/message.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class CoversationViewModel extends BaseViewModel {
  final HiveService hiveService = HiveService();
  final APIService apiService = APIService();

  List<Message> _messageList = [];
  List<Message> get conversationList => _messageList;
  String _text = "";
  String get text => _text;

  final String conversationUrl = API.conversation;

  getData() async {
    debugPrint("Entered get Data()");
    _text = "Fetching data";
    bool exists = await hiveService.isExists(boxName: "MessageList");
    if (exists) {
      _text = "Fetching from hive";
      debugPrint("Getting data from Hive");
      setBusy(true);
      _messageList = await hiveService.getBoxes("MessageList");
      setBusy(false);
    } else {
      _text = "Fetching from hive";
      debugPrint("Getting data from Api");
      setBusy(true);
      var result = await apiService.getRequest(conversationUrl);
      (result as List).map((e) {
        Message conversation = Message(
          id: e['id'],
          type: e['type'],
          from_system: e['from_system'],
          conversation_id: e['conversation_id'],
          conversation: e['conversation'],
          user_id: e['user_id'],
          user: e['user'],
          content: e['content'],
          attachable_type: e['attachable_type'],
          attachable_id: e['attachable_id'],
          attachable: e['attachable'],
          file_ids: e['file_ids'],
          files: e['files'],
          geolocation: e['geolocation'],
          created_at: e['created_at'],
          updated_at: e['updated_at'],
        );
        _messageList.add(conversation);
      }).toList();
      _text = "Caching data";
      await hiveService.addBoxes(_messageList, "MessageList");
      setBusy(false);
    }
  }
}
