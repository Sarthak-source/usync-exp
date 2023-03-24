
import 'package:redux_thunk/redux_thunk.dart';
import 'package:test/test.dart';
import 'package:redux/redux.dart';
import 'package:usync/services/audio_call/call_details.dart';
import 'dart:convert';

import 'audio_call_state.dart';

void main() {
  Store<RAudioCallState> store = Store<RAudioCallState>(audioCallStateReducer,
      initialState: RAudioCallState.defaultState(),
      middleware: [thunkMiddleware]);

  setUp(() {
    store = Store<RAudioCallState>(audioCallStateReducer,
        initialState: RAudioCallState.defaultState(),
        middleware: [thunkMiddleware]);
  });

  test('Test RAudioCallState data from null', () async {
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

    var data = CallDetails(
        conversationId: "fgh",
        caller: "fgh",
        callee: "asd",
        callerData: CallParticipantData.mapFromJson(callerData),
        calleeData: CallParticipantData.mapFromJson(calleeData));

    var result = RAudioCallState.fromJson(null);

    expect(result.speaker, false);
    expect(result.callDetails, null);

    result = RAudioCallState.fromJson(
        json.encode({'speaker': true, 'callDetails': data.toJson()}));
    expect(result.speaker, true);
    expect(result.callDetails != null, true);
  });

  test('Test user details is set to store', () async {
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

    var data = CallDetails(
        conversationId: "fgh",
        caller: "fgh",
        callee: "asd",
        callerData: CallParticipantData.mapFromJson(callerData),
        calleeData: CallParticipantData.mapFromJson(calleeData));


    expect(store.state.callDetails, null);
    await updateCallDetails(data)(store);
    expect(store.state.callDetails, data);
    expect(store.state.muted, true);
    await store.dispatch(CallDetailsAction());
    expect(store.state.callDetails, null);
  });

  test('Test speaker state', () async {
    expect(store.state.speaker, false);
    await store.dispatch(SpeakerActions.on);
    expect(store.state.speaker, true);
  });

  test('Test auth user id state', () async {
    expect(store.state.authUserID, null);
    await store.dispatch(AuthUserDataAction("123"));
    expect(store.state.authUserID, "123");
  });
}
