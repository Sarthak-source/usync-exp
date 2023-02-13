import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:event/event.dart';

class CallDetails extends EventArgs {
  CallDetails(
      {required this.conversationId,
      required this.caller,
      required this.callee,
      this.callerData,
      this.calleeData});

  String conversationId = "";
  late String caller;
  late String callee;

  CallParticipantData? callerData;
  CallParticipantData? calleeData;

  CallDetails.mapFromJson(Map callDetailsData) {
    final parsedCallerData = callDetailsData['callerData'] is String
        ? json.decode(callDetailsData['callerData'])
        : Map.from(callDetailsData['callerData']);
    final parsedCalleeData = callDetailsData['calleeData'] is String
        ? json.decode(callDetailsData['calleeData'])
        : Map.from(callDetailsData['calleeData']);

    conversationId = callDetailsData['conversationId'] ?? "";
    caller = callDetailsData['caller'];
    callee = callDetailsData['callee'];
    callerData = CallParticipantData.mapFromJson(parsedCallerData);
    calleeData = CallParticipantData.mapFromJson(parsedCalleeData);
  }

  String toPayload() {
    return json.encode(
        {"conversationId": conversationId, "caller": caller, "callee": callee});
  }

  Map toPayloadMap() {
    return {
      "conversationId": conversationId,
      "caller": caller,
      "callee": callee
    };
  }

  String toJson() {
    return json.encode({
      "conversationId": conversationId,
      "caller": caller,
      "callee": callee,
      "callerData": callerData,
      "calleeData": calleeData
    });
  }

  Map<String, dynamic> toMap() {
    return {
      "conversationId": conversationId,
      "caller": caller,
      "callee": callee,
      "callerData": callerData,
      "calleeData": calleeData
    };
  }

  CallDetails fromCaller() {
    return this;
  }

  fromCallee() {
    return CallDetails(
        conversationId: conversationId,
        caller: callee,
        callee: caller,
        callerData: calleeData,
        calleeData: callerData);
  }
}

class CallParticipantData {
  final String __type = "User";

  late String name;
  late dynamic avatarData;
  late Map avatar;

  @BuiltValueField(wireName: '_type')
  String get modelType => __type;

  String toJson() {
    return json
        .encode({"name": name, "avatar_data": avatarData, "avatar": avatar});
  }

  CallParticipantData.mapFromJson(Map user) {
    final userAvatar = Map.from(user['avatar']);
    final avatarId =
        userAvatar.containsKey('uuid') ? userAvatar['uuid'] : userAvatar['id'];

    name = user['name'];
    avatarData = user['avatar_data'];
    avatar = {
      "original_extension": userAvatar['original_extension'],
      "id": avatarId,
      "url": avatarId + userAvatar['original_extension']
    };
  }
}
