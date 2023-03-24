import 'package:flutter/cupertino.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:http/http.dart' as http;
import 'package:usync/utils/router.dart';
import 'package:usync/utils/usync_app.dart';

import 'audio_call_session_events.dart';
import 'audio_call_state.dart';

class AudioCallFgService {
  static final AudioCallFgService instance = AudioCallFgService._init();

  AudioCallFgService._init();

  Room? room;

  EventsListener<RoomEvent>? listener;

  late FlutterBackgroundService _bgService;

  final stopwatch = Stopwatch();

  void setBgServiceInstance(FlutterBackgroundService service) {
    _bgService = service;
  }

  void setEventhandlers() {
    _bgService.on(AudioCallSessionEvents.sessionOpen).listen((data) {
      stopwatch.reset();
    });

    _bgService.on(AudioCallSessionEvents.incomingCallHandled).listen((data) {
      NavRouter.instance.toRoute('/');
      stopwatch.reset();
    });

    _bgService.on(AudioCallSessionEvents.endCall).listen((data) async {
      stopwatch.stop();
      stopwatch.reset();
      await resetAudioCallState()(UsyncApp.instance.store);

      if (room != null) {
        // disconnect from room
        final roomName = room?.name;
        _bgService
            .invoke(AudioCallSessionEvents.deleteRoom, {"room": roomName});
        await room?.disconnect();
        await room?.dispose();
        //  Publish Delete Room
      }
    });

    _bgService.on(AudioCallSessionEvents.callEnded).listen((data) {
      NavRouter.instance.back();
    });

    _bgService.on(AudioCallSessionEvents.callAccepted).listen((data) {
      setConnecting(true)(UsyncApp.instance.store);
      stopwatch.start();
    });

    _bgService.on(AudioCallSessionEvents.initializeRoom).listen((data) async {
      if (data != null) {
        await _initializeRoom(data["room"]);
        _handleRoomJoined();
      }
    });

    _bgService.on(AudioCallSessionEvents.startCallProcess).listen((data) async {
      await _startCallProcess();
    });

    _bgService.on(AudioCallSessionEvents.setConnecting).listen((data) async {
      if (data != null) {
        setConnecting(data['connecting'])(UsyncApp.instance.store);
      }
    });

    _bgService
        .on(AudioCallSessionEvents.handleOutgoingCallRoomJoined)
        .listen((data) async {
      _handleRoomJoinedForOugoingCall();
    });
  }

  pickupCall() async {
    //   Stop incoming call ringtone
    // _acceptCall
    _bgService.invoke(AudioCallSessionEvents.pickUpCall);
  }

  declineCall() async {
    _bgService.invoke(AudioCallSessionEvents.declineCall);
  }

  _getJoinToken(String room) async {
    var authUserID = FromStore.authUserID;
    var url = Uri.parse(
        "${UsyncApp.instance.appEnv.gossipAppUrl}/room/$room/$authUserID");
    var response = await http.get(url);
    return response.body;
  }

  _createRoom() async {
    const roomOptions = RoomOptions(
      adaptiveStream: true,
      dynacast: true,
    );
    return Room(roomOptions: roomOptions);
  }

  void _registerRoomHandlers() {
    listener?.on<TrackSubscribedEvent>((TrackSubscribedEvent event) async {
      debugPrint({"TrackSubscribedEvent": event.track}.toString());
    });
    listener?.on<TrackUnsubscribedEvent>((TrackUnsubscribedEvent event) async {
      debugPrint({"TrackSubscribedEvent": event.track}.toString());
    });
    listener?.on<ActiveSpeakersChangedEvent>(
        (ActiveSpeakersChangedEvent event) async {
      debugPrint({"ActiveSpeakersChangedEvent": event.speakers}.toString());
    });
    listener?.on<RoomDisconnectedEvent>((_) async {});
    listener
        ?.on<LocalTrackPublishedEvent>((LocalTrackPublishedEvent event) async {
      debugPrint({"LocalTrackPublishedEvent": event.participant.trackPublications}.toString());
    });
    listener?.on<LocalTrackUnpublishedEvent>(
        (LocalTrackUnpublishedEvent event) async {
      debugPrint(
          {"LocalTrackUnpublishedEvent": event.participant.trackPublications}.toString());
    });
  }

  _connectToRoom(Room room, String token) async {
    await room.connect(UsyncApp.instance.appEnv.livekitServiceUrl, token);
    await room.localParticipant?.setMicrophoneEnabled(!FromStore.muted);
    return true;
  }

  _joinRoom(token) async {
    room = await _createRoom();

    listener = room?.createListener();
    // set room
    _registerRoomHandlers();

    return _connectToRoom(room!, token);
  }

  _initializeRoom(String room) async {
    // Get token
    final token = await _getJoinToken(room);
    // Join room
    await _joinRoom(token);
  }

  _handleRoomJoined() async {
    _bgService.invoke(AudioCallSessionEvents.handleRoomJoined);
    // Set call pickedup true
    setCallPickedUp(true)(UsyncApp.instance.store);
    // Publish Room joined

    // Start timer
    stopwatch.start();

    // Enable local participant microphone
    room?.localParticipant?.setMicrophoneEnabled(!FromStore.muted);

    // Set connecting false
    setConnecting(false)(UsyncApp.instance.store);
  }

  _handleRoomJoinedForOugoingCall() {
    setCallPickedUp(true)(UsyncApp.instance.store);
    stopwatch.start();
    room?.localParticipant?.setMicrophoneEnabled(!FromStore.muted);
    setConnecting(false)(UsyncApp.instance.store);
  }

  signalForCall() {
    _bgService.invoke(
        AudioCallSessionEvents.signalForCall, FromStore.callDetails?.toMap());
  }

  _startCallProcess() async {
    final roomName = FromStore.callDetails?.caller;
    if (roomName != null) {
      await _initializeRoom(roomName);
      _bgService.invoke(
          AudioCallSessionEvents.subscribeToCallProcess, {"room": roomName});
    }
  }

  toggleRoomSpeaker(bool value) {
    // if (room != null) {
    //   room?.participants.forEach((key, RemoteParticipant participant) {
    //     participant.audioTracks
    //         .forEach((RemoteTrackPublication<RemoteAudioTrack> element) {
    //       element.track!.mediaStreamTrack.enableSpeakerphone(value);
    //     });
    //   });
    // }
  }

  toggleRoomMic(bool value) {
    if (room != null) {
      room?.localParticipant?.setMicrophoneEnabled(value);
    }
  }
}

Future<void> initAudioCallFgService(
    FlutterBackgroundService serviceInstance) async {
  AudioCallFgService.instance.setBgServiceInstance(serviceInstance);
  AudioCallFgService.instance.setEventhandlers();
}
