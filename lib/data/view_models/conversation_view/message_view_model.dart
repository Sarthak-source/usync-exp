import 'package:flutter/material.dart';
import 'package:usync/data/hive_service/hive_service.dart';
import 'package:stacked/stacked.dart';
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
        debugPrint(
          e.toString(),
        );

        var userMap = e['user'];

        // if (userMap['avatar'] != null && userMap['avatar']['links'] != null) {
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
          links:
              userMap['avatar'] != null ? userMap['avatar']['links'] ?? {} : {},
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
          settings: userMap['settings'] as String?,
          username: userMap['username'] as String?,
          preferences: userMap['preferences'] != null
              ? Map<String, dynamic>.from(userMap['preferences'] as Map)
              : {},
        );

        Message conversation = Message(
          id: e['id'],
          type: e['type'],
          from_system: e['from_system'],
          conversation_id: e['conversation_id'],
          conversation: e['conversation'],
          user_id: e['user_id'],
          user: user,
          content: e['content'],
          attachable_type: e['attachable_type'],
          attachable_id: e['attachable_id'],
          attachable: e['attachable'],
          file_ids: e['file_ids'],
          // files: e['files'],
          // geolocation: e['geolocation'],
          created_at: e['created_at'],
          updated_at: e['updated_at'],
        );
        _messageList.add(conversation);
      }).toList();
      _text = "Caching data";
      await hiveService.addBoxes(_messageList, "MessageList$convesationId");
      setBusy(false);
    }
  }
}
