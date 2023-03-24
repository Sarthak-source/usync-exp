import 'dart:async';
import 'package:connectanum/authentication.dart';
import 'package:connectanum/connectanum.dart';
import 'package:connectanum/json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:usync/services/audio_call/call_details.dart';
import 'package:usync/utils/local_notifications.dart';
import 'package:usync/utils/usync_app.dart';
import 'audio_call_events.dart';
import 'audio_call_session_events.dart';
import 'audio_call_state.dart';

final player = AudioPlayer();

final duration = player.setUrl('rawresource://outgoing_call');

Future<Session> createSession(
    String gossipServiceUrl, String authToken, String authUserID) async {
  final client = Client(
      realm: 'usync.gossip',
      transport: WebSocketTransport(gossipServiceUrl, Serializer(),
          WebSocketSerialization.serializationJson),
      authId: authToken,
      authenticationMethods: [TicketAuthentication(authUserID)]);

  client.onNextTryToReconnect.listen((passedOptions) {
    // enlarge the time to wait after each reconnect by 500ms
    passedOptions.reconnectTime = Duration(
        milliseconds: passedOptions.reconnectTime!.inMilliseconds + 500);
  });

  return client
      .connect(
          options: ClientConnectOptions(
              reconnectCount: 10, // Default is 3
              reconnectTime: const Duration(
                  milliseconds: 200) // default is null, so immediately
              // you may add ping pong options here as well
              ))
      .first;
}

class AudioCallBgService {
  static final AudioCallBgService instance = AudioCallBgService._init();

  AudioCallBgService._init();

  bool connected = false;

  late String callerUserId;

  Session? session;

  late CallDetails callDetails;

  late StreamSubscription<Event>? callEndedSubscriptionStream;
  late StreamSubscription<Event>? callRequestSubscription;
  late StreamSubscription<Event>? callRejectedSubscriptionStream;
  late StreamSubscription<Event>? callReequstAcceptedSubscriptionStream;
  late StreamSubscription<Event>? joinRoomSubscriptionStream;
  late StreamSubscription<Event>? joinedRoomSubscriptionStream;

  late ServiceInstance _bgService;

  late FlutterLocalNotificationsPlugin _notificationsManager;

  _setEventHandlers() {
    _bgService.on(AudioCallSessionEvents.deleteRoom).listen((data) {
      if (data != null) {
        _deleteRoom(data['room']);
      }
    });

    _bgService.on(AudioCallSessionEvents.pickUpCall).listen((data) {
      _acceptCall();
    });

    _bgService.on(AudioCallSessionEvents.declineCall).listen((data) {
      _declineCall();
    });

    _bgService.on(AudioCallSessionEvents.handleRoomJoined).listen((data) {
      _handleRoomJoined();
    });

    _bgService.on(AudioCallSessionEvents.signalForCall).listen((data) async {
      if (data != null) {
        final callDetails =
            CallDetails.mapFromJson(Map<String, dynamic>.from(data));
        await updateCallDetails(callDetails)(UsyncApp.instance.store);
        _signalForCall();
      }
    });

    _bgService
        .on(AudioCallSessionEvents.subscribeToCallProcess)
        .listen((data) async {
      if (data != null) {
        _subscribeToCallProcess(data['room']);
      }
    });
  }

  void setBgServiceInstance(ServiceInstance service) {
    _bgService = service;
    _setEventHandlers();
  }

  void setNotificationsManager(
      FlutterLocalNotificationsPlugin notificationsManager) {
    _notificationsManager = notificationsManager;
  }

  openSession() async {
    _bgService.invoke(AudioCallSessionEvents.sessionOpen);

    // Subscribe to Call Request
    final subscription = await session?.subscribe(
        AudioCallEvents.userEvent(AudioCallEvents.callRequest, callerUserId));

    callRequestSubscription =
        subscription?.eventStream!.listen((Event event) async {
      final callDetails = CallDetails.mapFromJson(
          Map<String, dynamic>.from(event.arguments![0]));

      debugPrint({"callerDetails": callDetails.callerData?.name}.toString());

      // Set Call details
      await updateCallDetails(callDetails)(UsyncApp.instance.store);

      await _handleIncomingCall(callDetails.callerData?.name);
    });
  }

  _handleIncomingCall(String? callerName) async {
    if (callerName != null) {
      _showNotificationWithActions(callerName);
    }

    // Subscribe to Call Ended
    final subscription = await session?.subscribe(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.callEnded, FromStore.callDetails));

    callEndedSubscriptionStream =
        subscription?.eventStream!.listen((Event event) async {
      // Stop Incoming call ringing

      // unsubscribe from call ended event
      if (callEndedSubscriptionStream != null) {
        callEndedSubscriptionStream?.cancel();
      }

      // set call details null
      _destroyCall();
    });

    _incomingCallHandled();
  }

  _incomingCallHandled() async {
    _bgService.invoke(AudioCallSessionEvents.incomingCallHandled);

    //  subscribe to join room event
    final subscription = await session?.subscribe(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.joinRoom, FromStore.callDetails));

    joinRoomSubscriptionStream =
        subscription?.eventStream!.listen((Event event) async {
      String room = event.arguments![0] as String;

      _bgService.invoke(AudioCallSessionEvents.initializeRoom, {"room": room});

      if (joinRoomSubscriptionStream != null) {
        joinRoomSubscriptionStream?.cancel();
      }
    });
  }

  _handleRoomJoined() async {
    // Set call pickedup true
    // Publish Room joined
    await session?.publish(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.joinedRoom, FromStore.callDetails?.fromCallee()),
        arguments: [true]);
  }

  _declineCall() async {
    // Stop Incoming Call tone

    //  Publish Call Rejected
    await session?.publish(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.callRejected, FromStore.callDetails?.fromCallee()),
        arguments: [true]);

    // Destroy Call
    await _destroyCall();
  }

  _destroyCall() async {
    // end call
    await _endCall();

    if (session != null) {
      // Unsubscribe from all topics
    }
    _bgService.invoke(AudioCallSessionEvents.callEnded);
  }

  _endCall() async {
    _bgService.invoke(AudioCallSessionEvents.endCall);
  }

  _deleteRoom(String room) {
    session?.call(AudioCallEvents.deleteRoom, arguments: [room]);
  }

  _acceptCall() async {
    //   Publish call request accepted
    await session?.publish(
        AudioCallEvents.userConnectionEvent(AudioCallEvents.callRequestAccepted,
            FromStore.callDetails?.fromCallee()),
        arguments: [true]);

    _bgService.invoke(AudioCallSessionEvents.callAccepted);
  }

  _signalForCall() async {
    session?.call(AudioCallEvents.initCall, arguments: [
      FromStore.callDetails?.toPayloadMap()
    ]).listen((Result event) {
      final res = event.arguments![0] as bool;
      if (res) {
        _bgService.invoke(AudioCallSessionEvents.startCallProcess);
      }
    });
  }

  _subscribeToCallProcess(String roomName) async {
    final callRequestAcceptedSubscription = await session?.subscribe(
        AudioCallEvents.userConnectionEvent(AudioCallEvents.callRequestAccepted,
            FromStore.callDetails?.fromCallee()));

    callReequstAcceptedSubscriptionStream = callRequestAcceptedSubscription
        ?.eventStream!
        .listen((Event event) async {
      _bgService
          .invoke(AudioCallSessionEvents.setConnecting, {"connecting": true});

      await session?.publish(
          AudioCallEvents.userConnectionEvent(
              AudioCallEvents.joinRoom, FromStore.callDetails),
          arguments: [roomName]);

      final joinedRoomSubscription = await session?.subscribe(
          AudioCallEvents.userConnectionEvent(
              AudioCallEvents.joinedRoom, FromStore.callDetails?.fromCallee()));
      joinedRoomSubscriptionStream =
          joinedRoomSubscription?.eventStream!.listen((Event event) {
        //  Stop ougoing call tone
        //  handle room joined
        _bgService.invoke(AudioCallSessionEvents.handleOutgoingCallRoomJoined);

        if (joinedRoomSubscriptionStream != null) {
          joinedRoomSubscriptionStream?.cancel();
        }
      });

      if (callReequstAcceptedSubscriptionStream != null) {
        callReequstAcceptedSubscriptionStream?.cancel();
      }
    });

    final callRejectedSubscription = await session?.subscribe(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.callRejected, FromStore.callDetails?.fromCallee()));

    callRejectedSubscriptionStream =
        callRejectedSubscription?.eventStream!.listen((Event event) async {
      //  Stop ougoing call tone
      _destroyCall();

      if (callRejectedSubscriptionStream != null) {
        callRejectedSubscriptionStream?.cancel();
      }
    });

    final callEndedSubscription = await session?.subscribe(
        AudioCallEvents.userConnectionEvent(
            AudioCallEvents.callEnded, FromStore.callDetails?.fromCallee()));

    callEndedSubscriptionStream =
        callEndedSubscription?.eventStream!.listen((Event event) async {
      //  Stop ougoing call tone
      _destroyCall();

      if (callEndedSubscriptionStream != null) {
        callEndedSubscriptionStream?.cancel();
      }
    });
  }

  Future<void> _showNotificationWithActions(callerName) async {
     AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'call_notification',
      'call_notification',
      'call_notification',
      importance: Importance.max,
      priority: Priority.max,
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.call,
      fullScreenIntent: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          navigationActionId,
          'Decline',
          showsUserInterface: true,
          // By default, Android plugin will dismiss the notification when the
          // user tapped on a action (this mimics the behavior on iOS).
          cancelNotification: false,
        ),
        AndroidNotificationAction(urlLaunchActionId, 'Accept',
            showsUserInterface: true,
            icon: const DrawableResourceAndroidBitmap('ldpi')),
      ],
    );

     DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

     NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await _notificationsManager.show(1, 'Incoming call',
        'Incoming call from $callerName', notificationDetails,
        payload: 'item z');
  }
}
