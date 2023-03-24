import 'dart:convert';
import 'package:test/test.dart';

import 'call_details.dart';

void main() {
  test('CallDetails to Json', () {
    var expected = json.encode({
      "caller": "abc",
      "callee": "def",
      "callerData": null,
      "calleeData": null
    });

    expect(
        CallDetails(conversationId: "abc", caller: "abc", callee: "def")
            .toJson(),
        expected);
  });

  test('CallParticipantData to Json', () {
    var jsonData = {
      "name": "abc",
      "avatar_data": "def",
      "avatar": {
        "original_extension": ".jpg",
        "id": "id",
        "url": "id.jpg",
      },
    };

    var expected = json.encode(jsonData);
    CallParticipantData actual = CallParticipantData.mapFromJson(jsonData);

    expect(actual.toJson(), expected);
    expect(actual.modelType, "User");
  });

  test('CallDetails with CallParticipantData to Json', () {
    var callerData = {
      "name": "abc",
      "avatar_data": "def",
      "avatar": {
        "original_extension": ".jpg",
        "id": "id",
        "url": "id.jpg",
      },
    };

    var calleeData = {
      "name": "xyz",
      "avatar_data": "qwe",
      "avatar": {
        "original_extension": ".png",
        "id": "uuid",
        "url": "uuid.png",
      },
    };

    var expected = json.encode({
      "caller": "fgh",
      "callee": "asd",
      "callerData": json.encode(callerData),
      "calleeData": json.encode(calleeData)
    });

    expect(
        CallDetails(
                conversationId: "abc",
                caller: "fgh",
                callee: "asd",
                callerData: CallParticipantData.mapFromJson(callerData),
                calleeData: CallParticipantData.mapFromJson(calleeData))
            .toJson(),
        expected);
  });
}
