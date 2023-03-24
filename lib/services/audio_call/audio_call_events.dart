import 'package:usync/services/audio_call/call_details.dart';

// TODO: Create Event via object instance
class AudioCallEvents {
  static const String initCall = 'usync.gossip.initcall';
  static const String deleteRoom = 'usync.gossip.deleteroom';
  static const String callRequest = 'usync.gossip.callrequest';
  static const String callRejected = 'usync.gossip.callrejected';
  static const String callEnded = 'usync.gossip.callended';
  static const String callRequestAccepted = 'usync.gossip.callrequestaccepted';
  static const String joinRoom = 'usync.gossip.joinroom';
  static const String joinedRoom = 'usync.gossip.joinedroom';

  static userEvent(String event, String userId) {
    final eventParts = event.split('.');
    eventParts.insert(2, userId);
    return eventParts.join('.');
  }

  static userConnectionEvent(String event, dynamic caller, [dynamic callee]) {
    if (caller is CallDetails) {
      callee = caller.callee;
      caller = caller.caller;
    }
    final eventParts = event.split('.');
    final connection = [caller, "->", callee];
    eventParts.insert(2, connection.join());
    return eventParts.join('.');
  }
}
