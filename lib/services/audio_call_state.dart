import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_module/services/call_details.dart';
import 'package:flutter_module/usync_app.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

// Redux states

class RAudioCallState {
  final bool speaker;
  final bool muted;
  final CallDetails? callDetails;
  final String? authUserID;
  final String? authUserToken;
  final bool callPickedUp;
  final bool connecting;
  final bool reconnecting;

  RAudioCallState(
      {required this.speaker,
      required this.muted,
      required this.callDetails,
      required this.authUserID,
      required this.authUserToken,
      required this.callPickedUp,
      required this.connecting,
      required this.reconnecting});

  static RAudioCallState defaultState() {
    return RAudioCallState(
        speaker: false,
        muted: false,
        callDetails: null,
        callPickedUp: false,
        connecting: false,
        reconnecting: false,
        authUserID: null,
        authUserToken: null);
  }

  static RAudioCallState fromJson(dynamic jsonData) {
    if (jsonData != null) {
      jsonData = json.decode(jsonData);
    }
    return RAudioCallState(
        speaker: jsonData?["speaker"] ?? false,
        muted: jsonData?["muted"] ?? false,
        callPickedUp: jsonData?["callPickedUp"] ?? false,
        connecting: jsonData?["connecting"] ?? false,
        reconnecting: jsonData?["reconnecting"] ?? false,
        callDetails: jsonData?['callDetails'] != null
            ? CallDetails.mapFromJson(json.decode(jsonData['callDetails']))
            : null,
        authUserID:
            jsonData?['authUserID'] != null ? jsonData['authUserID'] : null,
        authUserToken: jsonData?['authUserToken'] != null
            ? jsonData['authUserToken']
            : null);
  }

  dynamic toJson() {
    return json.encode({
      'speaker': speaker,
      'muted': muted,
      'callDetails': callDetails?.toJson(),
      'callPickedUp': callPickedUp,
      'connecting': connecting,
      'reconnecting': reconnecting,
      'authUserID': authUserID,
      'authUserToken': authUserToken
    });
  }
}

enum SpeakerActions { on, off }

enum MicActions { mute, unMute }

class CallDetailsAction {
  late CallDetails? data;

  CallDetailsAction({this.data});
}

class ConnectionActions {
  late bool connecting;
  late bool reconnecting;

  ConnectionActions({this.connecting = false, this.reconnecting = false});
}

class CallPickedUpAction {
  bool value;

  CallPickedUpAction(this.value);
}

class AuthUserDataAction {
  late String? data;
  late String? token;
  AuthUserDataAction(this.data, {this.token});
}

bool speakerStateReducer(bool state, dynamic action) {
  switch (action) {
    case SpeakerActions.on:
      return true;
    case SpeakerActions.off:
      return false;
    default:
      return state;
  }
}

bool micStateReducer(bool state, dynamic action) {
  switch (action) {
    case MicActions.mute:
      return true;
    case MicActions.unMute:
      return false;
    default:
      return state;
  }
}

CallDetails? callDetailsReducer(CallDetails? state, dynamic action) {
  if (action is CallDetailsAction) {
    state = action.data;
  }
  return state;
}

bool connectingStateReducer(bool state, dynamic action) {
  if (action is ConnectionActions) {
    state = action.connecting;
  }
  return state;
}

bool reconnectingStateReducer(bool state, dynamic action) {
  if (action is ConnectionActions) {
    state = action.reconnecting;
  }
  return state;
}

bool callPickedUpStateReducer(bool state, dynamic action) {
  if (action is CallPickedUpAction) {
    state = action.value;
  }
  return state;
}

String? authUserIDReducer(String? state, dynamic action) {
  if (action is AuthUserDataAction) {
    state = action.data!;
  }
  return state;
}

String? authUserTokenReducer(String? state, dynamic action) {
  if (action is AuthUserDataAction) {
    state = action.token!;
  }
  return state;
}

RAudioCallState audioCallStateReducer(RAudioCallState state, action) =>
    RAudioCallState(
        speaker: speakerStateReducer(state.speaker, action),
        muted: micStateReducer(state.muted, action),
        callDetails: callDetailsReducer(state.callDetails, action),
        callPickedUp: callPickedUpStateReducer(state.callPickedUp, action),
        connecting: connectingStateReducer(state.connecting, action),
        reconnecting: reconnectingStateReducer(state.reconnecting, action),
        authUserID: authUserIDReducer(state.authUserID, action),
        authUserToken: authUserTokenReducer(state.authUserID, action));

ThunkAction<RAudioCallState> updateCallDetails(CallDetails callDetails) {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(MicActions.mute);
    await store.dispatch(CallDetailsAction(data: callDetails));
  };
}

ThunkAction<RAudioCallState> clearCallDetails() {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(CallDetailsAction());
  };
}

ThunkAction<RAudioCallState> resetAudioCallState() {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(CallDetailsAction());
    await store.dispatch(CallPickedUpAction(false));
    await store.dispatch(SpeakerActions.off);
    await store.dispatch(MicActions.unMute);
    await store
        .dispatch(ConnectionActions(connecting: false, reconnecting: false));
  };
}

ThunkAction<RAudioCallState> setCallPickedUp(bool value) {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(CallPickedUpAction(value));
  };
}

ThunkAction<RAudioCallState> setConnecting(bool value) {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(ConnectionActions(connecting: value));
  };
}

ThunkAction<RAudioCallState> setReconnecting(bool value) {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(ConnectionActions(reconnecting: value));
  };
}

ThunkAction<RAudioCallState> setAuthUserID(String? userID, String? authToken) {
  return (Store<RAudioCallState> store) async {
    await store.dispatch(AuthUserDataAction(userID, token: authToken));
  };
}

bool isIncomingCall(RAudioCallState state) {
  return (state.callDetails?.callee == state.authUserID);
}

bool isOutgoingCall(RAudioCallState state) {
  return (state.callDetails?.caller == state.authUserID);
}

bool incomingCallReceived(RAudioCallState state) {
  return !incomingCallNotReceived(state);
}

bool incomingCallNotReceived(RAudioCallState state) {
  return isIncomingCall(state) && notPickedUpOrConnecting(state);
}

bool notPickedUpOrConnecting(RAudioCallState state) {
  return !pickedUpOrConnecting(state);
}

bool pickedUpOrConnecting(RAudioCallState state) {
  // print({"state.callPickedUp": state.callPickedUp, "state.connecting": state.connecting});
  return (state.callPickedUp || state.connecting);
}

bool connectingOrReconnecting(RAudioCallState state) {
  return (state.connecting || state.reconnecting);
}

withStore(Store<RAudioCallState> store) {
  return (callback) {
    return callback(store.state);
  };
}

class FromStore {
  static CallDetails? get callDetails {
    return UsyncApp.instance.store.state.callDetails;
  }

  static bool get muted {
    return UsyncApp.instance.store.state.muted;
  }

  static String get authUserID {
    return UsyncApp.instance.store.state.authUserID ?? "";
  }

  static String get authUserToken {
    return UsyncApp.instance.store.state.authUserToken ?? "";
  }

  static bool get callIsIncomingCall {
    return isIncomingCall(UsyncApp.instance.store.state);
  }

   static bool get callIsOutgoingCall {
    return isOutgoingCall(UsyncApp.instance.store.state);
  }
}
