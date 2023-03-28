import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_audio_manager_plus/flutter_audio_manager_plus.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:usync/components/calltimer.dart';
import 'package:usync/services/audio_call/audio_call_fg_service.dart';
import 'package:usync/services/audio_call/audio_call_state.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/icon.dart';
import 'package:usync/ui_components/typography/text.dart';
import 'package:usync/utils/local_notifications.dart';
import 'package:usync/utils/usync_app.dart';

class AudioCallPage extends StatefulWidget {
  const AudioCallPage({super.key});

  @override
  AudioCallPageState createState() => AudioCallPageState();
}

class AudioCallPageState extends State<AudioCallPage> {
  AudioInput _currentInput = const AudioInput("unknow", 0);
  List<AudioInput> _availableInputs = [];

  get _micIcon {
    return StoreConnector<RAudioCallState, Store<RAudioCallState>>(
        converter: (store) => store,
        builder: (context, Store<RAudioCallState> store) {
          return store.state.muted
              ? QIcon(CupertinoIcons.mic_off, color: DarkThemeColors.primaryColor,
                  onPressed: () {
                  store.dispatch(MicActions.unMute);
                  AudioCallFgService.instance.toggleRoomMic(true);
                })
              : QIcon(
                  CupertinoIcons.mic,
                  color: DarkThemeColors.textColor,
                  onPressed: () {
                    store.dispatch(MicActions.mute);
                    AudioCallFgService.instance.toggleRoomMic(false);
                  },
                );
        });
  }

  get _speakerIcon {
    return StoreConnector<RAudioCallState, Store<RAudioCallState>>(
        converter: (store) => store,
        builder: (BuildContext context, Store<RAudioCallState> store) {
          return store.state.speaker
              ? QIcon(
                  CupertinoIcons.speaker_3,
                  color: DarkThemeColors.primaryColor,
                  onPressed: () async {
                    await Helper.setSpeakerphoneOn(false);
                    store.dispatch(SpeakerActions.off);
                    AudioCallFgService.instance.toggleRoomSpeaker(false);
                  },
                )
              : QIcon(
                  CupertinoIcons.speaker_3,
                  color: DarkThemeColors.textColor,
                  onPressed: () async {
                    await Helper.setSpeakerphoneOn(true);
                    store.dispatch(SpeakerActions.on);
                    AudioCallFgService.instance.toggleRoomSpeaker(true);
                  },
                );
        });
  }

  get _acceptCallIcon {
    return QIcon(
      CupertinoIcons.phone,
      color: DarkThemeColors.textColor,
      filled: true,
      filledColor: DarkThemeColors.primaryColor,
      onPressed: () {
        AudioCallFgService.instance.pickupCall();
      },
    );
  }

  get _callDetails {
    return StoreConnector<RAudioCallState, RAudioCallState>(
        converter: (store) => store.state,
        builder: (BuildContext context, RAudioCallState audioCallState) {
          String callingStatus = isIncomingCall(audioCallState)
              ? 'Incoming call...'
              : 'Calling...';

          String avatar = "";
          String userName = "";

          if (audioCallState.callDetails != null) {
            if (isIncomingCall(audioCallState)) {
              final avatarId =
                  audioCallState.callDetails?.callerData?.avatar["id"];
              avatar = resolveMediaUrl(
                  media: audioCallState.callDetails?.callerData?.avatar as Map,
                  size: "xs",
                  path: "img/$avatarId");

              userName = audioCallState.callDetails?.callerData?.name as String;
            } else {
              final avatarId =
                  audioCallState.callDetails?.calleeData?.avatar["id"];
              avatar = resolveMediaUrl(
                  media: audioCallState.callDetails?.calleeData?.avatar as Map,
                  size: "xs",
                  path: "img/$avatarId");
              userName = audioCallState.callDetails?.calleeData?.name as String;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Avatar(
                  imageUrl: [avatar],
                  border: 3.0,
                  size: 70,
                  borderColor: DarkThemeColors.primaryColor,
                  padding: const EdgeInsets.only(bottom: 20),
                ),
                UsyncText(
                  userName,
                  type: UsyncTextType.title3Regular,
                  padding: const EdgeInsets.only(bottom: 10),
                ),
                if (notPickedUpOrConnecting(audioCallState))
                  UsyncText(callingStatus,
                      type: UsyncTextType.subHeadlineBold,
                      padding: const EdgeInsets.only(bottom: 10)),
                if (connectingOrReconnecting(audioCallState))
                  const UsyncText("Connecting...",
                      type: UsyncTextType.subHeadlineBold,
                      padding: EdgeInsets.only(bottom: 10)),
                if (audioCallState.callPickedUp &&
                    AudioCallFgService.instance.stopwatch.isRunning)
                  const CallTimer(),
                if (audioCallState.callPickedUp && audioCallState.muted)
                  const UsyncText('Muted',
                      type: UsyncTextType.subHeadlineRegular,
                      padding: EdgeInsets.only(bottom: 8)),
                if (audioCallState.callPickedUp && audioCallState.speaker)
                  const UsyncText('On speaker',
                      type: UsyncTextType.subHeadlineRegular,
                      padding: EdgeInsets.only(bottom: 8)),
                UsyncText(
                    "current output:${_currentInput.name} ${_currentInput.port}",
                    type: UsyncTextType.subHeadlineRegular,
                    padding: const EdgeInsets.only(bottom: 8)),
              ],
            ),
          );
        });
  }

  get _callDisconnect {
    return QIcon(
      CupertinoIcons.phone_down,
      color: DarkThemeColors.textColor,
      filled: true,
      filledColor: DarkThemeColors.negativeColor,
      onPressed: () async {
        AudioCallFgService.instance.declineCall();
      },
    );
  }

  get _callButtons {
    return StoreConnector<RAudioCallState, Store<RAudioCallState>>(
        converter: (store) => store,
        builder: (BuildContext context, Store<RAudioCallState> store) {
          debugPrint({
            "incomingCallNotReceived(store.state)":
                incomingCallNotReceived(store.state)
          }.toString());
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (incomingCallNotReceived(store.state)) _acceptCallIcon,
              if (incomingCallReceived(store.state)) _speakerIcon,
              if (incomingCallReceived(store.state)) _micIcon,
              _callDisconnect,
            ],
          );
        });
  }

  // bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();

    if (FromStore.callIsOutgoingCall) {
      AudioCallFgService.instance.signalForCall();
    }

    init();

    // _isAndroidPermissionGranted();
    // _requestPermissions();
    // _configureDidReceiveLocalNotificationSubject();
    // _configureSelectNotificationSubject();
  }

  Future<void> init() async {
    FlutterAudioManagerPlus.setListener(() async {
      debugPrint("-----changed-------");
      await _getInput();
      setState(() {});
    });
    FlutterAudioManagerPlus.changeToReceiver();
    await _getInput();
    if (!mounted) return;
    setState(() {});
  }

  _getInput() async {
    _currentInput = await FlutterAudioManagerPlus.getCurrentOutput();
    debugPrint("current:$_currentInput");
    _availableInputs = await FlutterAudioManagerPlus.getAvailableInputs();
    debugPrint("available $_availableInputs");
  }

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              !.areNotificationsEnabled() ??
          false;

      //   setState(() {
      //     _notificationsEnabled = granted;
      //   });
      // }
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      // setState(() {
      //   _notificationsEnabled = granted ?? false;
      // });
    }
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {},
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {});
  }

  Future<void> showNotification() async {
    debugPrint("Showing notification");
     AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'audio_call',
      'Audio Call',
       'Audio call notifications channel',
      importance: Importance.max,
      priority: Priority.max,
      icon: 'avd_incoming_call',
      ticker: 'ticker',
      // fullScreenIntent: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'id_2',
          'Answer Call',
          titleColor: const Color.fromARGB(255, 255, 0, 0),
          icon: const DrawableResourceAndroidBitmap('ldpi'),
        ),
        AndroidNotificationAction(
          navigationActionId,
          'Reject Call',
          icon: const DrawableResourceAndroidBitmap('ldpi'),
          showsUserInterface: true,
          // By default, Android plugin will dismiss the notification when the
          // user tapped on a action (this mimics the behavior on iOS).
          cancelNotification: false,
        ),
      ],
    );

     DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

     NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        10, 'Incoming call', 'from Darell Lynn', notificationDetails,
        payload: 'item x');
  }

  Future<void> showFullScreenNotification(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Turn off your screen'),
        content: const Text(
            'to see the full-screen intent in 5 seconds, press OK and TURN '
            'OFF your screen'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              // await flutterLocalNotificationsPlugin.zonedSchedule(
              //     0,
              //     'scheduled title',
              //     'scheduled body',
              //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
              //     const NotificationDetails(
              //         android: AndroidNotificationDetails(
              //             'full screen channel id', 'full screen channel name',
              //             channelDescription: 'full screen channel description',
              //             priority: Priority.high,
              //             importance: Importance.high,
              //             fullScreenIntent: true)),
              //     androidAllowWhileIdle: true,
              //     uiLocalNotificationDateInterpretation:
              //     UILocalNotificationDateInterpretation.absoluteTime);
              //
              // Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Call method that need to called when the app is sent to background
          await resetAudioCallState()(UsyncApp.instance.store);
          //  return false when audio calling is in progress
          return true;
        },
        child: CupertinoPageScaffold(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[_callDetails, _callButtons],
              ),
            ),
          ),
        ));
  }
}
